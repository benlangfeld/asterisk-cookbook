default['asterisk']['package']['debs']              = %w(asterisk asterisk-dev)
default['asterisk']['package']['repo']['enable']    = false
default['asterisk']['package']['repo']['url']       = 'http://packages.asterisk.org/deb'
default['asterisk']['package']['repo']['distro']    = node['lsb']['codename']
default['asterisk']['package']['repo']['branches']  = %w(main)
default['asterisk']['package']['repo']['keyserver'] = 'pgp.mit.edu'
default['asterisk']['package']['repo']['key']       = '175E41DF'

