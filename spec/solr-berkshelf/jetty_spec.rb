require 'spec_helper'

describe 'jetty' do
  it { should be_enabled }
  it { should be_running }
end

describe 'port 8085' do
  it { should be_listening }
end

describe '/etc/default/jetty' do
  it { should be_file }
end

describe '/etc/init.d/jetty' do
  it { should be_file }
end
