#
# Cookbook Name:: solr
# Recipe:: solr
#
# Copyright (C) 2013 Darron Froese
# 
# All rights reserved - Do Not Redistribute
#

package "unzip"

cookbook_file "/etc/security/limits.d/solr.conf" do
  owner "root"
  group "root"
  mode "0644"
  action :create
end

ark "solr" do
  url "#{node[:solr][:url]}"
  version "4.2.0"
  owner "#{node[:jetty][:user]}"
  action :install
end

directory "#{node[:solr][:path]}" do
  owner "#{node[:jetty][:user]}"
  group "#{node[:jetty][:user]}"
  mode 0755
  action :create
end

directory "#{node[:solr][:path]}/cores" do
  owner "#{node[:jetty][:user]}"
  group "#{node[:jetty][:user]}"
  mode 0755
  action :create
end

ark "core1" do
  url "#{node[:solr_core][:url]}"
  owner "#{node[:jetty][:user]}"
  action :put
  path "#{node[:solr][:path]}/cores/"
end

bash "install solr" do
  user "root"
  cwd "#{node[:solr][:prefix]}"
  code <<-EOH
    cp /usr/local/solr/dist/solr-4.2.0.war #{node[:jetty][:path]}/webapps/solr.war
    cp -R /usr/local/solr/example/solr/* #{node[:solr][:path]}
    cp -R /usr/local/solr/dist #{node[:solr][:path]}
    cp -R /usr/local/solr/contrib #{node[:solr][:path]}
    chown -R #{node[:jetty][:user]}.#{node[:jetty][:user]} #{node[:solr][:path]}
  EOH
  not_if { FileTest.exists?("#{node[:jetty][:path]}/webapps/solr.war") }
end

# Only install new solr.xml if it's the default install.
template "#{node[:solr][:path]}/solr.xml" do
  source "solr.erb"
  owner "#{node[:jetty][:user]}"
  group "#{node[:jetty][:user]}"
  mode "0644"
  action :create
  notifies :restart, resources(:service => "jetty")
  only_if "grep collection1 #{node[:solr][:path]}/solr.xml"
end