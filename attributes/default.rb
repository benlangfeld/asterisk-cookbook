default['asterisk']['install_method']   = 'package'
default['asterisk']['use_digium_repo']  = false
default['asterisk']['packages']         = ['asterisk', 'asterisk-dev']

#Setup the Manager.conf file, refer to: http://www.voip-info.org/tiki-index.php?page=Asterisk%20config%20manager.conf
#[general]
default['asterisk']['manager_enabled']         = 'yes'
default['asterisk']['manager_port']            = 5038
default['asterisk']['manager_ip_address']      = '127.0.0.1'
default['asterisk']['manager_webenabled']      = 'yes'
default['asterisk']['manager_timestampevents'] = 'yes'

#[user] section
default['asterisk']['manager_username']    = 'manager'
default['asterisk']['manager_password']    = 'password'
default['asterisk']['manager_deny']        = '0.0.0.0/0.0.0.0'
default['asterisk']['manager_permit']      = '127.0.0.1/255.255.255.0'
default['asterisk']['manager_read_perms']  = %w(system call log verbose command agent user config)
default['asterisk']['manager_write_perms'] = %w(system call log verbose command agent user config)

#Setup the SIP.conf file, refer to: http://www.voip-info.org/wiki/view/Asterisk+config+sip.conf
default['asterisk']['sip_conf_context']              = 'default'
default['asterisk']['sip_conf_allowguest']           = 'yes'
default['asterisk']['sip_confallowoverlap']          = 'no'
default['asterisk']['sip_conf_allowtransfer']        = 'no'
default['asterisk']['sip_conf_realm']                = 'mydomain.com'
default['asterisk']['sip_conf_domain']               = 'mydomain.com'
default['asterisk']['sip_conf_bindport']             = 5060
default['asterisk']['sip_conf_bindaddr']             = '0.0.0.0'
default['asterisk']['sip_conf_tcpenable']            = 'yes'
default['asterisk']['sip_conf_srvlookup']            = 'yes'
default['asterisk']['sip_conf_pedantic']             = 'yes'
default['asterisk']['sip_conf_tos_sip']              = 'cs3'
default['asterisk']['sip_conf_tos_audio']            = 'ef'
default['asterisk']['sip_conf_tos_video']            = 'af41'
default['asterisk']['sip_conf_maxexpiry']            = '3600'
default['asterisk']['sip_conf_minexpiry']            = 60
default['asterisk']['sip_conf_defaultexpiry']        = 120
default['asterisk']['sip_conf_t1min']                = 100
default['asterisk']['sip_conf_notifymimetype']       = 'text/plain'
default['asterisk']['sip_conf_checkmwi']             = 10
default['asterisk']['sip_conf_buggymwi']             = 'no'
default['asterisk']['sip_conf_vmexten']              = 'voicemail'
default['asterisk']['sip_conf_disallow']             = 'all'
default['asterisk']['sip_conf_allow']                = %w(ulaw gsm ilbc speex)
default['asterisk']['sip_conf_mohinterpret']         = 'default'
default['asterisk']['sip_conf_mohsuggest']           = 'default'
default['asterisk']['sip_conf_language']             = 'en'
default['asterisk']['sip_conf_relaxdtmf']            = 'yes'
default['asterisk']['sip_conf_trustrpid']            = 'no'
default['asterisk']['sip_conf_sendrpid']             = 'yes'
default['asterisk']['sip_conf_progressinband']       = 'never'
default['asterisk']['sip_conf_useragent']            = 'Asterisk with Adhearsion'
default['asterisk']['sip_conf_promiscredir']         = 'no'
default['asterisk']['sip_conf_usereqphone']          = 'no'
default['asterisk']['sip_conf_dtmfmode']             = 'rfc2833'
default['asterisk']['sip_conf_compactheaders']       = 'yes'
default['asterisk']['sip_conf_videosupport']         = 'yes'
default['asterisk']['sip_conf_maxcallbitrate']       = 384
default['asterisk']['sip_conf_callevents']           = 'no'
default['asterisk']['sip_conf_alwaysauthreject']     = 'yes'
default['asterisk']['sip_conf_g726nonstandard']      = 'yes'
default['asterisk']['sip_conf_matchexterniplocally'] = 'yes'
default['asterisk']['sip_conf_regcontext']           = 'sipregistrations'
default['asterisk']['sip_conf_rtptimeout']           = 60
default['asterisk']['sip_conf_rtpholdtimeout']       = 300
default['asterisk']['sip_conf_rtpkeepalive']         = 60
default['asterisk']['sip_conf_sipdebug']             = 'yes'
default['asterisk']['sip_conf_recordhistory']        = 'yes'
default['asterisk']['sip_conf_dumphistory']          = 'yes'
default['asterisk']['sip_conf_allowsubscribe']       = 'no'
default['asterisk']['sip_conf_subscribecontext']     = 'default'
default['asterisk']['sip_conf_notifyringing']        = 'yes'
default['asterisk']['sip_conf_notifyhold']           = 'yes'
default['asterisk']['sip_conf_limitonpeers']         = 'yes'
default['asterisk']['sip_conf_t38pt_udptl']          = 'yes'

#Setup our SIP Providers
default['asterisk']['sip_providers'] = Mash.new
default['asterisk']['sip_providers']['flowroute'] = Mash.new(:type => 'friend', :host => 'sip.flowroute.com', :dtmf_mode => 'rfc2833', :context => 'flowroute', :canreinvite => 'no', :allowed_codecs => ['ulaw', 'g729'], :insecure => 'port,invite', :qualify => 'yes')

# uncomment the following to set an explicit public IP for SIP behind NAT. Default is the current host's ip address (or ec2 public IP if on ec2)
# asterisk[:public_ip] = '1.2.3.4'

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
