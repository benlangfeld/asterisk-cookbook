users = search(:asterisk_users) || []
auth = search(:auth, "id:google") || []
dialplan_contexts = search(:asterisk_contexts) || []

node.default['asterisk']['users'] = users
node.default['asterisk']['auth']  = auth
node.default['asterisk']['dialplan_contexts'] = dialplan_contexts

node['asterisk']['configure'].each do |config, managed|
  next unless managed == true
  template "/etc/asterisk/#{config}.conf" do
    source "#{config}.conf.erb"
    mode 0644
    notifies :reload, resources(:service => 'asterisk')
  end
end

