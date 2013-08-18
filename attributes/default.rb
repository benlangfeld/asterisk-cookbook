default['asterisk']['install_method']      = 'package'
default['asterisk']['enable_service']      = true
default['asterisk']['enable_components']   = %w(sip manager modules extensions gtalk jabber)
default['asterisk']['external_ip']         = node[:ec2] ? node[:ec2][:public_ipv4] : node[:ipaddress]

# Ownership / run-as user
default['asterisk']['user']                = 'asterisk'
default['asterisk']['group']               = 'asterisk'

# Install paths.  Defaults correspond to package installs.
default['asterisk']['prefix']['bin']       = '/usr'
default['asterisk']['prefix']['conf']      = '/etc'
default['asterisk']['prefix']['state']     = '/var'

#Setup the Manager.conf file, refer to: http://www.voip-info.org/tiki-index.php?page=Asterisk%20config%20manager.conf
#[general]
default['asterisk']['manager']['enabled'] = 'yes'
default['asterisk']['manager']['port'] = 5038
default['asterisk']['manager']['ip_address'] = '127.0.0.1'
default['asterisk']['manager']['webenabled'] = 'yes'
default['asterisk']['manager']['timestampevents'] = 'yes'

#[user] section
default['asterisk']['manager']['username'] = 'manager'
default['asterisk']['manager']['password'] = 'password'
default['asterisk']['manager']['deny'] = '0.0.0.0/0.0.0.0'
default['asterisk']['manager']['permit'] = '127.0.0.1/255.255.255.0'
default['asterisk']['manager']['read_perms'] = %w(system call log verbose command agent user config)
default['asterisk']['manager']['write_perms'] = %w(system call log verbose command agent user config)


#Setup the SIP.conf file, refer to: http://www.voip-info.org/wiki/view/Asterisk+config+sip.conf
default['asterisk']['sip']['context'] = 'default'
default['asterisk']['sip']['allowguest'] = 'yes'
default['asterisk']['sip_confallowoverlap'] = 'no'
default['asterisk']['sip']['allowtransfer'] = 'no'
default['asterisk']['sip']['realm'] = 'mydomain.com'
default['asterisk']['sip']['domain'] = 'mydomain.com'
default['asterisk']['sip']['bindport'] = 5060
default['asterisk']['sip']['bindaddr'] = '0.0.0.0'
default['asterisk']['sip']['tcpenable'] = 'yes'
default['asterisk']['sip']['srvlookup'] = 'yes'
default['asterisk']['sip']['pedantic'] = 'yes'
default['asterisk']['sip']['tos_sip'] = 'cs3'
default['asterisk']['sip']['tos_audio'] = 'ef'
default['asterisk']['sip']['tos_video'] = 'af41'
default['asterisk']['sip']['maxexpiry'] = '3600'
default['asterisk']['sip']['minexpiry'] = 60
default['asterisk']['sip']['defaultexpiry'] = 120
default['asterisk']['sip']['t1min'] = 100
default['asterisk']['sip']['notifymimetype'] = 'text/plain'
default['asterisk']['sip']['checkmwi'] = 10
default['asterisk']['sip']['buggymwi'] = 'no'
default['asterisk']['sip']['vmexten'] = 'voicemail'
default['asterisk']['sip']['disallow'] = 'all'
default['asterisk']['sip']['allow'] = %w(ulaw gsm ilbc speex)
default['asterisk']['sip']['mohinterpret'] = 'default'
default['asterisk']['sip']['mohsuggest'] = 'default'
default['asterisk']['sip']['language'] = 'en'
default['asterisk']['sip']['relaxdtmf'] = 'yes'
default['asterisk']['sip']['trustrpid'] = 'no'
default['asterisk']['sip']['sendrpid'] = 'yes'
default['asterisk']['sip']['progressinband'] = 'never'
default['asterisk']['sip']['useragent'] = 'Asterisk with Adhearsion'
default['asterisk']['sip']['promiscredir'] = 'no'
default['asterisk']['sip']['usereqphone'] = 'no'
default['asterisk']['sip']['dtmfmode'] = 'rfc2833'
default['asterisk']['sip']['compactheaders'] = 'yes'
default['asterisk']['sip']['videosupport'] = 'yes'
default['asterisk']['sip']['maxcallbitrate'] = 384
default['asterisk']['sip']['callevents'] = 'no'
default['asterisk']['sip']['alwaysauthreject'] = 'yes'
default['asterisk']['sip']['g726nonstandard'] = 'yes'
default['asterisk']['sip']['matchexterniplocally'] = 'yes'
default['asterisk']['sip']['regcontext'] = 'sipregistrations'
default['asterisk']['sip']['rtptimeout'] = 60
default['asterisk']['sip']['rtpholdtimeout'] = 300
default['asterisk']['sip']['rtpkeepalive'] = 60
default['asterisk']['sip']['sipdebug'] = 'yes'
default['asterisk']['sip']['recordhistory'] = 'yes'
default['asterisk']['sip']['dumphistory'] = 'yes'
default['asterisk']['sip']['allowsubscribe'] = 'no'
default['asterisk']['sip']['subscribecontext'] = 'default'
default['asterisk']['sip']['notifyringing'] = 'yes'
default['asterisk']['sip']['notifyhold'] = 'yes'
default['asterisk']['sip']['limitonpeers'] = 'yes'
default['asterisk']['sip']['t38pt_udptl'] = 'yes'

#Setup our SIP Providers
default['asterisk']['sip']['providers'] = Mash.new
default['asterisk']['sip']['providers']['flowroute'] = Mash.new(
    :type => 'friend',
    :host => 'sip.flowroute.com',
    :dtmf_mode => 'rfc2833',
    :context => 'flowroute',
    :canreinvite => 'no',
    :allowed_codecs => %w(ulaw g729),
    :insecure => 'port,invite',
    :qualify => 'yes'
)
