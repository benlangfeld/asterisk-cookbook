case node['platform']
when "ubuntu","debian"
  node['asterisk']['source']['packages'].each do |pkg|
    package pkg do
      options "--force-yes"
    end
  end
end

# http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-11.3.0.tar.gz

remote_file "/usr/local/src/asterisk-#{node['asterisk']['source']['version']}.tar.gz" do
  source "http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-#{node['asterisk']['source']['version']}.tar.gz"
end

bash "prepare_dir" do
  user "root"
  cwd "/usr/local/src"
  code <<-EOH
    tar -zxf asterisk-#{node['asterisk']['source']['version']}.tar.gz
  EOH
end

bash "install_asterisk" do
  user "root"
  cwd "/usr/local/src/asterisk-#{node['asterisk']['source']['version']}"
  code <<-EOH
    ./configure
    make
    make install
    make config
    make samples
  EOH
  notifies :reload, resources(:service => "asterisk")
end
