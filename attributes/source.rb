default['asterisk']['source']['packages'] = value_for_platform_family(
  'debian' => %w{libssl-dev libcurl4-openssl-dev libjansson-dev libncurses5-dev libnewt-dev libxml2-dev libsqlite3-dev uuid-dev sox},
  'rhel' => %w{jansson-devel openssl-devel ncurses-devel newt-devel libxml2-devel sqlite-devel uuid-devel sox}
)

default['asterisk']['source']['version']  = '13-current'
default['asterisk']['source']['checksum'] = 'f381b2184579e4f3e0a2f758a5db9b2cdd628fa35b1c9e69d0325047b69790be'

# An full download url can be supplied to specify an alternative source tarball location
default['asterisk']['source']['url'] = nil

# Should the sample config files be installed?
default['asterisk']['source']['install_samples'] = true
