case node['platform_family']
when 'rhel', 'fedora'
  package 'net-tools'
end
