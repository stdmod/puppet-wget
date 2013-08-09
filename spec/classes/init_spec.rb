# require 'spec_helper'
require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'wget' do

  let(:title) { 'wget' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { {
    :ipaddress => '10.42.42.42',
  } }

  describe 'Test default settings  ' do
    it 'should install wget package' do should contain_package('wget').with_ensure('present') end
    it 'should manage config file presence' do should contain_file('wget.conf').with_ensure('present') end
  end

  describe 'Test installation of a specific version' do
    let(:params) { {:version => '1.0.42' } }
    it { should contain_package('wget').with_ensure('1.0.42') }
  end

  describe 'Test decommissioning' do
    let(:params) { {:ensure => 'absent'} }
    it 'should remove Package[wget]' do should contain_package('wget').with_ensure('absent') end
    it 'should remove wget configuration file' do should contain_file('wget.conf').with_ensure('absent') end
  end

  describe 'Test custom file via template' do
    let(:params) { {
      :file_template => 'wget/spec/spec.conf.erb',
      :file_options_hash => { 'opt_a' => 'value_a' },
    } }
    it { should contain_file('wget.conf').with_content(/fqdn: rspec.example42.com/) }
    it 'should generate a template that uses custom options' do
      should contain_file('wget.conf').with_content(/value_a/)
    end
  end

  describe 'Test custom file via source' do
    let(:params) { {:file_source => "puppet:///modules/wget/spec/spec.conf"} }
    it { should contain_file('wget.conf').with_source('puppet:///modules/wget/spec/spec.conf') }
  end

end
