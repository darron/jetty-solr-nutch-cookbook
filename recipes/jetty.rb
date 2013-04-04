#
# Cookbook Name:: solr
# Recipe:: jetty
#
# Copyright (C) 2013 Darron Froese
# 
# All rights reserved - Do Not Redistribute
#

user "jetty" do
  comment "Jetty User"
  shell "/bin/false"
end

ark "jetty" do
  url 'http://192.168.2.145:8080/jetty.tar.gz'
  path "/opt"
  owner "jetty"
  action :put
end

cookbook_file "/etc/default/jetty" do
  owner "root"
  group "root"
  mode "0644"
  action :create
end

bash "remove insecure apps" do
  user "root"
  cwd "/opt/jetty/webapps"
  code <<-EOH
    rm -rf test.d/ test.war test.xml async-rest.war
  EOH
end

bash "jetty init script" do
  user "root"
  cwd "/etc"
  code <<-EOH
    cp /opt/jetty/bin/jetty.sh /etc/init.d/jetty
    chmod 755 /etc/init.d/jetty
  EOH
end

service "jetty" do
  action [ :start, :enable ]
end