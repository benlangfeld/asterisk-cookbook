defaults_path = case node['platform_family']
when 'debian'
  '/etc/default/asterisk'
when 'rhel', 'fedora'
  '/etc/default/asterisk'
end

template defaults_path do
  source 'init/default-asterisk.erb'
  mode 0644
  owner 'root'
  group 'root'
  notifies :restart, 'service[asterisk]'
end
