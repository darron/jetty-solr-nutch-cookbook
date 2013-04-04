#
# Cookbook Name:: solr
# Recipe:: nutch
#
# Copyright (C) 2013 Darron Froese
# 
# All rights reserved - Do Not Redistribute
#

package "patch"

ark "nutch" do
  url 'http://192.168.2.145:8080/apache-nutch-1.6-bin.tar.gz'
  path "/opt"
  owner "jetty"
  action :put
end

template "/etc/profile.d/java.sh" do
  source "java.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

# Patch broken crawl script.
cookbook_file "/opt/nutch/bin/nutch-patch.txt" do
  owner "root"
  group "root"
  mode "0644"
  action :create
end

bash "patch nutch" do
  user "root"
  cwd "/opt/nutch/bin"
  code <<-EOH
    patch < nutch-patch.txt
    touch patched
  EOH
  not_if {File.exists?("/opt/nutch/bin/patched")}
end

bash "source java profile" do
  user "root"
  cwd "/opt"
  code <<-EOH
    source /etc/profile.d/java.sh
  EOH
  only_if {File.exists?("/etc/profile.d/java.sh")}
end