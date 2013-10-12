# UniMRCP settings
default['asterisk']['unimrcp']['version'] = '1.0.0'
default['asterisk']['unimrcp']['packages'] = %w{pkg-config build-essential}
default['asterisk']['unimrcp']['install_dir'] = '/usr/local/unimrcp'
default['asterisk']['unimrcp']['server_ip'] = '192.168.10.14'
default['asterisk']['unimrcp']['server_port'] = '5060'
default['asterisk']['unimrcp']['client_ip'] = '192.168.10.11'
default['asterisk']['unimrcp']['client_port'] = '25097'
default['asterisk']['unimrcp']['rtp_ip'] = '192.168.10.11'
default['asterisk']['unimrcp']['rtp_port_min'] = '28000'
default['asterisk']['unimrcp']['rtp_port_max'] = '29000'
