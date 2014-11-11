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

  describe file("/etc/asterisk/extensions.conf") do
    it {
      should contain(<<-CONTEXT
[adhearsion]
exten => _.,1,AGI(agi:async)
      CONTEXT
      )
    }
  end

  describe file("/etc/asterisk/sip.conf") do
    it {
      should contain(<<-CONTEXT
[usera]
defaultuser=usera
secret=usera
type=friend
callerid="User A <usera>"
host=dynamic
context=adhearsion
      CONTEXT
      )
    }
  end

  describe package('sox') do
    it { should be_installed }
  end

  describe command('sox --version') do
    its(:exit_status) { should eq 0 }
  end
end
