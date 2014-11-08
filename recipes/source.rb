include_recipe 'apt'

include_recipe 'build-essential'

node['asterisk']['source']['packages'].each do |pkg|
  package pkg do
    options "--force-yes" if node['platform_family'] == 'debian'
  end
end

version = node['asterisk']['source']['version']
certified = true if version.match(/cert/)
chksum = node['asterisk']['source']['checksum']
source_tarball = "#{'certified-' if certified}asterisk-#{version}.tar.gz"
source_url_prefix = "http://downloads.asterisk.org/pub/telephony/#{'certified-' if certified}asterisk/"
source_url_prefix << 'releases/' unless version.match(/current/)
source_url = node['asterisk']['source']['url'] ||
    source_url_prefix + source_tarball
source_path = "#{Chef::Config['file_cache_path'] || '/tmp'}/#{source_tarball}"

menuselect_command = nil
if (!node['asterisk']['source']['enable_opts'].empty? || !node['asterisk']['source']['disable_opts'].empty?)
  menuselect_command = "menuselect/menuselect "
  menuselect_command += node['asterisk']['source']['enable_opts'].map {|opt| "--enable #{opt}"}.join(" ")
  menuselect_command += node['asterisk']['source']['disable_opts'].map {|opt| "--disable #{opt}"}.join(" ")
end

remote_file source_tarball do
  source source_url
  path source_path
  checksum chksum
  backup false
  notifies :create, 'ruby_block[validate asterisk tarball]', :immediately
end

# The checksum on remote_file is used only to determine if a file needs downloading
# Here we verify the checksum for security/integrity purposes
ruby_block 'validate asterisk tarball' do
  action :nothing
  block do
    require 'digest'
    expected = chksum
    actual = Digest::SHA256.file(source_path).hexdigest
    if expected and actual != expected
      raise "Checksum mismatch on #{source_path}.  Expected sha256 of #{expected} but found #{actual} instead"
    end
  end
  only_if { chksum }
end

bash "install_asterisk" do
  user "root"
  cwd File.dirname(source_path)
  code <<-EOH
    tar zxf #{source_path}
    cd #{'certified-' if certified}asterisk-#{version =~ /(\d*)-current/ ? "#{$1}.*" : version}
    ./contrib/scripts/install_prereq install
    ./configure --prefix=#{node['asterisk']['prefix']['bin']} --sysconfdir=#{node['asterisk']['prefix']['conf']} --localstatedir=#{node['asterisk']['prefix']['state']} #{node['asterisk']['source']['configure_opts']}
    #{'make menuselect.makeopts' if menuselect_command}
    #{menuselect_command}
    make
    make install
    make config
    #{'make samples' if node['asterisk']['source']['install_samples']}
    ldconfig
  EOH
  not_if "test -f #{node['asterisk']['prefix']['bin']}/sbin/asterisk"
  notifies :reload, 'service[asterisk]'
end
