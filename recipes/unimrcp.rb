node.default['asterisk']['configure']['mrcp'] = true

case node['platform']
when "ubuntu","debian"
  node['asterisk']['unimrcp']['packages'].each do |pkg|
    package pkg do
      options "--force-yes"
    end
  end
end

unimrcp_name = "uni-ast-package-#{node['asterisk']['unimrcp']['version']}"
work_dir = "/tmp"
unimrcp_src_dir = "#{work_dir}/#{unimrcp_name}"

target_dir = node['asterisk']['unimrcp']['install_dir']

apr_src_dir = "#{unimrcp_src_dir}/unimrcp/libs/apr"
aprutil_src_dir = "#{unimrcp_src_dir}/unimrcp/libs/apr-util"
sofia_src_dir = "#{unimrcp_src_dir}/unimrcp/libs/sofia-sip"

remote_file "#{work_dir}/#{unimrcp_name}.tar.gz" do
  source "http://unimrcp.googlecode.com/files/#{unimrcp_name}.tar.gz"
end

bash "prepare_dir" do
  user "root"
  cwd work_dir
  code <<-EOH
    tar -zxf #{unimrcp_name}.tar.gz
  EOH
end

bash "install_apr" do
  user "root"
  cwd work_dir
  code <<-EOH
    cd #{apr_src_dir}
    ./configure --prefix=#{target_dir}
    make
    make install
  EOH
end

bash "install_apr_util" do
  user "root"
  cwd work_dir
  code <<-EOH
    cd #{aprutil_src_dir}
    ./configure --prefix=#{target_dir} --with-apr=#{apr_src_dir}
    make
    make install
  EOH
end

bash "install_sofia" do
  user "root"
  cwd work_dir
  code <<-EOH
    cd #{sofia_src_dir}
    ./configure --with-glib=no
    make
    make install
  EOH
end

bash "install_unimrcp" do
  user "root"
  cwd work_dir
  code <<-EOH
    cd #{unimrcp_src_dir}/unimrcp
    ./configure --prefix=#{target_dir} --with-apr=#{target_dir} --with-apr-util=#{target_dir}
    make
    make install
  EOH
end

directory "/var/lib/asterisk/documentation/thirdparty" do
  mode 0644
  action :create
  recursive true
end

bash "install_asterisk_modules" do
  user "root"
  cwd work_dir
  code <<-EOH
    cd #{unimrcp_src_dir}/modules
    ./configure
    make
    make install
  EOH
end

bash "ldconfig" do
  user "root"
  cwd work_dir
  code <<-EOH
    ldconfig
  EOH
end
