# Dependencies and version
default['asterisk']['source']['version']  = '11.3.0'
default['asterisk']['source']['checksum'] = '35b7dd5d21449384ebcab631915a844d631676ff6535a6c14bd2bac819808f09'
default['asterisk']['source']['build_deps'] = %w{
  build-essential
  libssl-dev
  libncurses5-dev
  libnewt-dev
  libxml2-dev
  libsqlite3-dev
}

# 'url' can be set to specify an absolute download url
default['asterisk']['source']['url']      = nil
