case node['platform']
when 'ubuntu', 'debian'
  node['asterisk']['source']['build_deps'].each do |pkg|
    package pkg
  end
end

# By default use /opt location for source install
node.default['asterisk']['prefix']['bin'] = "/opt/asterisk-#{node['asterisk']['source']['version']}"

# Source tarball handling
source_tarball = "asterisk-#{node['asterisk']['source']['version']}.tar.gz"
source_url = node['asterisk']['source']['url'] ||
  "http://downloads.asterisk.org/pub/telephony/asterisk/releases/#{source_tarball}"
source_path = "#{Chef::Config['file_cache_path'] || '/tmp'}/#{source_tarball}"

# Configure according to prefix attributes.
# TODO: support --enable/--disable according to node['asterisk']['enable_components']
config_flags = %W(
  --prefix=#{node['asterisk']['prefix']['bin']}
  --sysconfdir=#{node['asterisk']['prefix']['conf']}
  --localstatedir=#{node['asterisk']['prefix']['state']}
)

remote_file source_tarball do
  source source_url
  path source_path
  checksum node['asterisk']['source']['checksum']
  notifies :create, 'ruby_block[validate asterisk tarball]', :immediately
  backup false
end

# The checksum on remote_file is used only to determine if a file needs downloading
# Here we verify the checksum for security/integrity purposes
ruby_block 'validate asterisk tarball' do
  action :nothing
  block do
    require 'digest'
    expected = node['asterisk']['source']['checksum']
    actual = Digest::SHA256.file(source_path).hexdigest
    if expected and actual != expected
      raise "Checksum mismatch on #{source_path}.  Expected sha256 of #{expected} but found #{actual} instead"
    end
  end
end

bash 'install_asterisk' do
  user 'root'
  cwd File.dirname(source_path)
  code <<-EOH
    tar zxf #{source_path}
    cd asterisk-#{node['asterisk']['source']['version']}
    ./configure #{config_flags.join(' ')}
    make
    make install
    make config
    make samples
  EOH
end
