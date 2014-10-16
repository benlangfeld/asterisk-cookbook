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

  describe package('sox') do
    it { should be_installed }
  end

  describe command('sox --version') do
    it { should return_exit_status 0 }
  end
end
