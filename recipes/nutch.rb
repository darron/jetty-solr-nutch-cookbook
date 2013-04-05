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
  url "#{node[:nutch][:url]}"
  path "#{node[:nutch][:prefix]}"
  owner "#{node[:jetty][:user]}"
  action :put
end

template "/etc/profile.d/java.sh" do
  source "java.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :java_path => node[:java][:path]
  )
  action :create
end

# Patch broken crawl script.
cookbook_file "#{node[:nutch][:path]}/bin/nutch-patch.txt" do
  owner "root"
  group "root"
  mode "0644"
  action :create
end

bash "patch nutch" do
  user "root"
  cwd "#{node[:nutch][:path]}/bin"
  code <<-EOH
    patch < nutch-patch.txt
    touch patched
  EOH
  not_if {File.exists?("#{node[:nutch][:path]}/bin/patched")}
end

bash "source java profile" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    source /etc/profile.d/java.sh
  EOH
  only_if {File.exists?("/etc/profile.d/java.sh")}
end