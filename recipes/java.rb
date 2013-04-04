#
# Cookbook Name:: solr
# Recipe:: java
#
# Copyright (C) 2013 Darron Froese
# 
# All rights reserved - Do Not Redistribute
#

package "openjdk-7-jdk"

directory "/usr/java" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

link "/usr/java/default" do
  to "/usr/lib/jvm/java-7-openjdk-amd64"
end