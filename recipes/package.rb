case node['platform']
when 'ubuntu', 'debian'
  if node['asterisk']['package']['use_digium_repo']
    apt_repository 'asterisk' do
      uri 'http://packages.asterisk.org/deb'
      distribution node['lsb']['codename']
      components %w(main)
      keyserver 'pgp.mit.edu'
      key '175E41DF'
    end
  end

  node['asterisk']['package']['debs'].each do |pkg|
    package pkg
  end
end
