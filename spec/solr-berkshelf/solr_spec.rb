require 'spec_helper'

describe '/opt/solr' do
  it { should be_directory }
end

describe '/opt/solr/cores' do
  it { should be_directory }
end

describe '/opt/solr/solr.xml' do
  it { should be_file }
end

describe '/opt/jetty/webapps/solr.war' do
  it { should be_file }
end