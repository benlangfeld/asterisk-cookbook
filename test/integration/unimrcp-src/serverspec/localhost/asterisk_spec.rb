require 'spec_helper'

describe 'asterisk' do
  describe user('asterisk') do
    it { should exist }
    it { should belong_to_group 'asterisk' }
  end

  describe service('asterisk') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(5060) do
    it { should be_listening.with('tcp') }
    it { should be_listening.with('udp') }
  end

  describe command('sudo asterisk -x "module show like unimrcp"') do
    its(:stdout) { should match /2 modules loaded/ }
  end
end
