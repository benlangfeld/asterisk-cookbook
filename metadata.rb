name             'asterisk'
maintainer       'Mojo Lingo'
maintainer_email 'ops@mojolingo.com'
license          'Apache 2.0'
description      'Installs/Configures Asterisk'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

recipe 'asterisk', 'Install Asterisk and configure'
recipe 'asterisk::unimrcp', 'Install Asterisk UniMRCP plugin and configure'

depends 'apt', '~> 2.2'
depends 'build-essential'
depends 'unimrcp', '~> 1.0'
depends 'yum', '~> 3.0'
depends 'yum-epel'

supports 'debian', '>= 7.1'
supports 'ubuntu', '>= 10.04'
supports 'centos', '>= 6.5'
supports 'fedora', '>= 19'
