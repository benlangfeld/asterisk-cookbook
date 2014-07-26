# Asterisk cookbook

This Chef cookbook installs Asterisk either from source or packages and configures its basic settings. It also optionally installs the UniMRCP module. It is intended that this cookbook remain small and perform only installation tasks, with downstream cookbooks depending on it to configure Asterisk for more specific tasks.

# Requirements

Tested on Ubuntu 12.04, Debian 7.1, CentOS 6.5 and Fedora 19 & 20.

# Usage

Add `recipe[asterisk]` to your node's run list. Optionally add `recipe[asterisk::unimrcp]`.

# Attributes

* `node['asterisk']['install_method']` - the method by which to install Asterisk. May be `package` or `source`. This choice determines other applicable parameters. (default `source`)
* `node['asterisk']['user']` - the user as which to run Asterisk (default `asterisk`)
* `node['asterisk']['group']` - the group as which to run Asterisk (default `asterisk`)
* `node['asterisk']['prefix']['bin']` - the prefix at which Asterisk is installed (default `/usr`)
* `node['asterisk']['prefix']['conf']` - the prefix at which Asterisk configuration is located (default `/etc`)
* `node['asterisk']['prefix']['state']` - the path at which Asterisk's runtime state located (default `/var`)

## Source install attributes
* `node['asterisk']['source']['packages']` - the packages to be installed on which compilation depends (default `%w{build-essential libssl-dev libcurl4-openssl-dev libncurses5-dev libnewt-dev libxml2-dev libsqlite3-dev uuid-dev}`)
* `node['asterisk']['source']['version']` - the version of Asterisk to install (default `11.6.0`)
* `node['asterisk']['source']['checksum']` - the checksum of the source distribution (default `80aa523bdaab71ce419022d8c851aaeda718dc5bbf5fe8cb99786da546dd8cee`)
* `node['asterisk']['source']['url']` - the url from which to download Asterisk (default `nil`)
* `node['asterisk']['source']['install_samples']` - wether or not to install sample config (default `true`)

## Package install attributes

* `node['asterisk']['package']['names']` - the Asterisk packages to install (default `%w(asterisk asterisk-dev)`)
* `node['asterisk']['package']['repo']['enable']` - if the Asterisk official repository should be enabled (default `false`)

### On Debian/Ubuntu systems:

* `node['asterisk']['package']['repo']['url']` - the URL of the Asterisk official repo (default `http://packages.asterisk.org/deb`)
* `node['asterisk']['package']['repo']['distro']` - the distro to select from the repo (default `node['lsb']['codename']`)
* `node['asterisk']['package']['repo']['branches']` - the branches of the repo to import (default `%w(main)`)
* `node['asterisk']['package']['repo']['keyserver']` - the keyserver against which to auth the repo (default `pgp.mit.edu`)
* `node['asterisk']['package']['repo']['key']` - the repo's public GPG key (default `175E41DF`)

### On RHEL/CentOS based systems:

* `node['asterisk']['package']['repo']['urls']` - the names / URLs of the Asterisk official repos (default `{
  'asterisk-11' => 'http://packages.asterisk.org/centos/$releasever/asterisk-11/$basearch/',
  'asterisk-current' => 'http://packages.asterisk.org/centos/$releasever/current/$basearch/',
}`)

## SIP attributes
* `node['asterisk']['sip']['context']` - (default `'default'`)
* `node['asterisk']['sip']['allowguest']` - (default `'yes'`)
* `node['asterisk']['sip']['allowoverlap']` - (default `'no'`)
* `node['asterisk']['sip']['allowtransfer']` - (default `'no'`)
* `node['asterisk']['sip']['realm']` - (default `'mydomain.com'`)
* `node['asterisk']['sip']['domain']` - (default `'mydomain.com'`)
* `node['asterisk']['sip']['bindport']` - (default `5060`)
* `node['asterisk']['sip']['bindaddr']` - (default `'0.0.0.0'`)
* `node['asterisk']['sip']['tcpenable']` - (default `'yes'`)
* `node['asterisk']['sip']['srvlookup']` - (default `'yes'`)
* `node['asterisk']['sip']['pedantic']` - (default `'yes'`)
* `node['asterisk']['sip']['tos_sip']` - (default `'cs3'`)
* `node['asterisk']['sip']['tos_audio']` - (default `'ef'`)
* `node['asterisk']['sip']['tos_video']` - (default `'af41'`)
* `node['asterisk']['sip']['maxexpiry']` - (default `'3600'`)
* `node['asterisk']['sip']['minexpiry']` - (default `60`)
* `node['asterisk']['sip']['defaultexpiry']` - (default `120`)
* `node['asterisk']['sip']['t1min']` - (default `100`)
* `node['asterisk']['sip']['notifymimetype']` - (default `'text/plain'`)
* `node['asterisk']['sip']['checkmwi']` - (default `10`)
* `node['asterisk']['sip']['buggymwi']` - (default `'no'`)
* `node['asterisk']['sip']['vmexten']` - (default `'voicemail'`)
* `node['asterisk']['sip']['disallow']` - (default `'all'`)
* `node['asterisk']['sip']['allow']` - (default `%w(ulaw gsm ilbc speex)`)
* `node['asterisk']['sip']['mohinterpret']` - (default `'default'`)
* `node['asterisk']['sip']['mohsuggest']` - (default `'default'`)
* `node['asterisk']['sip']['language']` - (default `'en'`)
* `node['asterisk']['sip']['relaxdtmf']` - (default `'yes'`)
* `node['asterisk']['sip']['trustrpid']` - (default `'no'`)
* `node['asterisk']['sip']['sendrpid']` - (default `'yes'`)
* `node['asterisk']['sip']['progressinband']` - (default `'never'`)
* `node['asterisk']['sip']['useragent']` - (default `'Asterisk with Adhearsion'`)
* `node['asterisk']['sip']['promiscredir']` - (default `'no'`)
* `node['asterisk']['sip']['usereqphone']` - (default `'no'`)
* `node['asterisk']['sip']['dtmfmode']` - (default `'rfc2833'`)
* `node['asterisk']['sip']['compactheaders']` - (default `'yes'`)
* `node['asterisk']['sip']['videosupport']` - (default `'yes'`)
* `node['asterisk']['sip']['maxcallbitrate']` - (default `384`)
* `node['asterisk']['sip']['callevents']` - (default `'no'`)
* `node['asterisk']['sip']['alwaysauthreject']` - (default `'yes'`)
* `node['asterisk']['sip']['g726nonstandard']` - (default `'yes'`)
* `node['asterisk']['sip']['matchexterniplocally']` - (default `'yes'`)
* `node['asterisk']['sip']['regcontext']` - (default `'sipregistrations'`)
* `node['asterisk']['sip']['rtptimeout']` - (default `60`)
* `node['asterisk']['sip']['rtpholdtimeout']` - (default `300`)
* `node['asterisk']['sip']['rtpkeepalive']` - (default `60`)
* `node['asterisk']['sip']['sipdebug']` - (default `'yes'`)
* `node['asterisk']['sip']['recordhistory']` - (default `'yes'`)
* `node['asterisk']['sip']['dumphistory']` - (default `'yes'`)
* `node['asterisk']['sip']['allowsubscribe']` - (default `'no'`)
* `node['asterisk']['sip']['subscribecontext']` - (default `'default'`)
* `node['asterisk']['sip']['notifyringing']` - (default `'yes'`)
* `node['asterisk']['sip']['notifyhold']` - (default `'yes'`)
* `node['asterisk']['sip']['limitonpeers']` - (default `'yes'`)
* `node['asterisk']['sip']['t38pt_udptl']` - (default `'yes'`)
* `node['asterisk']['public_ip']` - the public IP Asterisk listens on (default `node['ec2'] ? node['ec2']['public_ipv4'] : node['ipaddress']`)

## Manager attributes
* `node['asterisk']['manager']['enabled']` - wether or not to enable AMI (default `yes`)
* `node['asterisk']['manager']['port']` - the port on which to listen for AMI connections (default `5038`)
* `node['asterisk']['manager']['ip_address']` - the IP address on which to accept AMI connections (default `node['ec2'] ? node['ec2']['public_ipv4'] : node['ipaddress']`)
* `node['asterisk']['manager']['webenabled']` - enable AMI web connections (default `yes`)
* `node['asterisk']['manager']['timestampevents']` - wether or not to timestamp AMI events (default `yes`)
* `node['asterisk']['manager']['username']` - the username with which to authenticate AMI connections (default `manager`)
* `node['asterisk']['manager']['password']` - the password with which to authenticate AMI connections (default `password`)
* `node['asterisk']['manager']['deny']` - the ACL to deny access to (default `0.0.0.0/0.0.0.0`)
* `node['asterisk']['manager']['permit']` - the ACL to allow access to (default `127.0.0.1/255.255.255.0`)
* `node['asterisk']['manager']['read_perms']` - the AMI event classes to send to this user (default `%w(system call log verbose command agent user config)`)
* `node['asterisk']['manager']['write_perms']` - the AMI command classes to allow for this user (default `%w(system call log verbose command agent user config)`)

## UniMRCP attributes
* `node['asterisk']['unimrcp']['version']` - the version of UniMRCP to install (default `1.1.0'`)
* `node['asterisk']['unimrcp']['packages'] - the UniMRCP package dependencies to install (default %w{pkg-config build-essential}`)
* `node['asterisk']['unimrcp']['install_dir']` - the directory in which to install UniMRCP (default `/usr/local/unimrcp'`)
* `node['asterisk']['unimrcp']['server_ip']` - the IP of the MRCP server to connect to (default `127.0.0.1`)
* `node['asterisk']['unimrcp']['server_port']` - the MRCP server port to connect to (default `5060'`)
* `node['asterisk']['unimrcp']['client_ip']` - the IP of the MRCP client (default `node['ec2'] ? node['ec2']['public_ipv4'] : node['ipaddress']`)
* `node['asterisk']['unimrcp']['client_port']` - the MRCP client port (default `25097'`)
* `node['asterisk']['unimrcp']['rtp_ip']` - the client RTP IP to listen on (default `node['ec2'] ? node['ec2']['public_ipv4'] : node['ipaddress']`)
* `node['asterisk']['unimrcp']['rtp_port_min']` - the minimum RTP port (default `28000'`)
* `node['asterisk']['unimrcp']['rtp_port_max']` - the maximum RTP port (default `29000'`)

# Recipes

* `asterisk` - Fetches and installs Asterisk
* `asterisk::unimrcp` - Fetches and installs mod_unimrcp

# Author

[Ben Langfeld](@benlangfeld)

