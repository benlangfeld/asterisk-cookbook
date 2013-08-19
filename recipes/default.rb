#
# Cookbook Name:: asterisk
# Recipe:: default
#
# Copyright 2011, Chris Peplin
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#users = search(:asterisk_users) || []
#auth = search(:auth, 'id:google') || []
#dialplan_contexts = search(:asterisk_contexts) || []
asterisk_user = node['asterisk']['user']
asterisk_group = node['asterisk']['group']

case node['asterisk']['install_method']
  when 'package'
    include_recipe 'asterisk::package'
  when 'source'
    include_recipe 'asterisk::source'
end

user node['asterisk']['user'] do
  system true
  shell '/bin/false'
  home "#{node['asterisk']['prefix']['state']}/lib/asterisk"
end

group node['asterisk']['group'] do
  system true
end

%w(lib/asterisk spool/asterisk run/asterisk log/asterisk).each do |subdir|
  path = "#{node['asterisk']['prefix']['state']}/#{subdir}"
  directory path do
    owner asterisk_user
    group asterisk_group
    recursive true
    only_if { ! File.directory?(path) }
  end
  execute "#{path} ownership" do
    command "chown -Rf #{asterisk_user}:#{asterisk_group} #{path}"
    only_if { Etc.getpwuid(File.stat(path).uid).name != asterisk_user or Etc.getgrgid(File.stat(path).gid).name != asterisk_group}
  end
end

template '/etc/default/asterisk' do
  source 'init/default-asterisk.erb'
  mode 0644
end

template '/etc/init.d/asterisk' do
  source 'init/init-asterisk.erb'
  mode 0755
end

service 'asterisk' do
  supports :restart => true, :reload => true, :status => :true
  action [:enable] if node['asterisk']['enable_service']
  subscribes :restart, resources(:template => '/etc/default/asterisk'), :delayed
  subscribes :restart, resources(:template => '/etc/init.d/asterisk'), :delayed
end

template "#{node['asterisk']['prefix']['conf']}/asterisk/asterisk.conf" do
  source 'config/asterisk.conf.erb'
  mode 0644
  notifies :reload, resources(:service => 'asterisk'), :delayed
end

node['asterisk']['enable_components'].each do |component|
  case component
    when 'unimrcp'
      include_recipe 'aterisk::unimrcp'
    else
      template "#{node['asterisk']['prefix']['conf']}/asterisk/#{component}.conf" do
        source "config/#{component}.conf.erb"
        mode 0644
        #variables :users => users, :auth => auth[0], :dialplan_contexts => dialplan_contexts
        notifies :reload, resources(:service => 'asterisk'), :delayed
      end
  end
end
