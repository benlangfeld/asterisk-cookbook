#
# Cookbook Name:: asterisk
# Recipe:: default
#
# Copyright 2011, Chris Peplin
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

users = search(:asterisk_users) || []
auth = search(:auth, 'id:google') || []
dialplan_contexts = search(:asterisk_contexts) || []

case node['asterisk']['install_method']
  when 'package'
    include_recipe 'asterisk::package'
  when 'source'
    include_recipe 'asterisk::source'
end

service 'asterisk' do
  supports :restart => true, :reload => true, :status => :true, :debug => :true,
           'logger-reload' => true, 'extensions-reload' => true,
           'restart-convenient' => true, 'force-reload' => true
  action :enable if node['asterisk']['enable_service']
end

template "#{node['asterisk']['prefix']['conf']}/asterisk/asterisk.conf" do
  source 'config/asterisk.conf.erb'
  mode 0644
  notifies :reload, resources(:service => 'asterisk')
end

node['asterisk']['enable_components'].each do |component|
  case component
    when 'unimrcp'
      include_recipe 'aterisk::unimrcp'
    else
      template "#{node['asterisk']['prefix']['conf']}/asterisk/#{component}.conf" do
        source "config/#{component}.conf.erb"
        mode 0644
        variables :users => users, :auth => auth[0], :dialplan_contexts => dialplan_contexts
        notifies :reload, resources(:service => 'asterisk')
      end
  end
end
