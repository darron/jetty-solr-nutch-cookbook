#
# Cookbook Name:: solr
# Recipe:: solr
#
# Copyright (C) 2013 Darron Froese
# 
# All rights reserved - Do Not Redistribute
#

package "unzip"

ark "solr" do
  url 'http://192.168.2.145:8080/solr-4.2.0.tgz'
  version "4.2.0"
  owner "jetty"
  action :install
end

directory "/opt/solr" do
  owner "jetty"
  group "jetty"
  mode 0755
  action :create
end

directory "/opt/solr/cores" do
  owner "jetty"
  group "jetty"
  mode 0755
  action :create
end

ark "core1" do
  url "https://github.com/darron/solr-nutch-core/archive/master.zip"
  owner "jetty"
  action :put
  path "/opt/solr/cores/"
end

bash "install solr" do
  user "root"
  cwd "/opt"
  code <<-EOH
    cp /usr/local/solr/dist/solr-4.2.0.war /opt/jetty/webapps/solr.war
    cp -R /usr/local/solr/example/solr/* /opt/solr/
    cp -R /usr/local/solr/dist /opt/solr
    cp -R /usr/local/solr/contrib /opt/solr
    chown -R jetty.jetty /opt/solr
  EOH
  not_if { FileTest.exists?("/opt/jetty/webapps/solr.war") }
end


template "/opt/solr/solr.xml" do
  source "solr.erb"
  owner "jetty"
  group "jetty"
  mode "0644"
  action :create
  notifies :restart, resources(:service => "jetty")
  not_if { FileTest.exists?("/opt/solr/solr.xml") }
end