#
# Cookbook Name:: solr
# Recipe:: default
#
# Copyright (C) 2013 Darron Froese
# 
# All rights reserved - Do Not Redistribute
#
# Based on: http://pietervogelaar.nl/ubuntu-12-04-install-jetty-9/

template "/etc/apt/apt.conf.d/01proxy" do
  source "01proxy.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

execute "apt-get-update" do
  command "apt-get update"
end

include_recipe "solr::jetty"
include_recipe "solr::solr"