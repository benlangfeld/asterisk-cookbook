case node['platform_family']
when 'debian'
  apt_repository 'asterisk' do
    uri node['asterisk']['package']['repo']['url']
    distribution node['asterisk']['package']['repo']['distro']
    components node['asterisk']['package']['repo']['branches']
    keyserver node['asterisk']['package']['repo']['keyserver']
    key node['asterisk']['package']['repo']['key']
    only_if { node['asterisk']['package']['repo']['enable'] }
  end
when 'rhel'
  include_recipe 'yum-epel'
end

node['asterisk']['package']['names'].each do |pkg|
  package pkg
end
