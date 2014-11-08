default['asterisk']['source']['packages'] = case platform_family
when 'debian'
  %w{libssl-dev libcurl4-openssl-dev libncurses5-dev libnewt-dev libxml2-dev libsqlite3-dev libsrtp0-dev uuid-dev sox}
when 'rhel'
  %w{openssl-devel ncurses-devel newt-devel libxml2-devel sqlite-devel uuid-devel sox}
end
default['asterisk']['source']['version']  = '11-current'
default['asterisk']['source']['checksum'] = nil

# An full download url can be supplied to specify an alternative source tarball location
default['asterisk']['source']['url'] = nil

# Should the sample config files be installed?
default['asterisk']['source']['install_samples'] = true

# Additional configuration options
default['asterisk']['source']['configure_opts'] = nil
default['asterisk']['source']['enable_opts'] = []
default['asterisk']['source']['disable_opts'] = []