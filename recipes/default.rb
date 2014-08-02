asterisk_user = node['asterisk']['user']
asterisk_group = node['asterisk']['group']

user asterisk_user do
  system true
end

group asterisk_group do
  system true
end

include_recipe "asterisk::#{node['asterisk']['install_method']}"

service "asterisk" do
  supports :restart => true, :reload => true, :status => :true, :debug => :true,
    "logger-reload" => true, "extensions-reload" => true,
    "restart-convenient" => true, "force-reload" => true
  action :enable
end

%w(lib/asterisk spool/asterisk run/asterisk log/asterisk).each do |subdir|
  path = "#{node['asterisk']['prefix']['state']}/#{subdir}"

  directory path do
    recursive true
  end

  execute "#{path} ownership" do
    command "chown -Rf #{asterisk_user}:#{asterisk_group} #{path}"
  end
end

include_recipe 'asterisk::config'
include_recipe 'asterisk::init'
