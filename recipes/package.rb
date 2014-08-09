case node['platform_family']
when 'debian'
  if node['asterisk']['package']['repo']['enable']
    apt_repository 'asterisk' do
      uri node['asterisk']['package']['repo']['url']
      distribution node['asterisk']['package']['repo']['distro']
      components node['asterisk']['package']['repo']['branches']
      keyserver node['asterisk']['package']['repo']['keyserver']
      key node['asterisk']['package']['repo']['key']
    end
  end
when 'rhel'
  if node['asterisk']['package']['repo']['enable']
    node['asterisk']['package']['repo']['urls'].each do |name, url|
      yum_repository name do
        description "Asterisk yum repo"
        baseurl url
        gpgcheck false
        action :create
      end
    end
  else
    include_recipe 'yum-epel'
  end
end

node['asterisk']['package']['names'].each do |pkg|
  package pkg
end
