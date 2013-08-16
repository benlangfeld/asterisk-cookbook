case node['platform']
when "ubuntu","debian"
  node['asterisk']['source']['packages'].each do |pkg|
    package pkg do
      options "--force-yes"
    end
  end
end

source_tarball = "asterisk-#{node['asterisk']['source']['version']}.tar.gz"
source_url = node['asterisk']['source']['url'] ||
  "http://downloads.asterisk.org/pub/telephony/asterisk/releases/#{source_tarball}"
source_path = "#{Chef::Config['file_cache_path'] || '/tmp'}/#{source_tarball}"

remote_file source_tarball do
  source source_url
  path source_path
  checksum node['asterisk']['source']['checksum']
  backup false
end

bash "install_asterisk" do
  user "root"
  cwd File.dirname(source_path)
  code <<-EOH
    tar zxf #{source_path}
    cd asterisk-#{node['asterisk']['source']['version']}
    ./configure
    make
    make install
    make config
    make samples
  EOH
  notifies :reload, resources(:service => "asterisk")
end
