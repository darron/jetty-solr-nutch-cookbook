default[:apt][:proxy] = true
default[:apt][:proxy_host] = "192.168.2.145"

default[:java][:prefix] = "/usr/java"
default[:java][:path] = "/usr/java/default"

default[:jetty][:prefix] = "/opt"
default[:jetty][:path] = "/opt/jetty"
default[:jetty][:listen_ports] = "8085"
default[:jetty][:user] = "jetty"
default[:jetty][:url] = "http://192.168.2.145:8080/jetty.tar.gz"

default[:solr][:prefix] = "/opt"
default[:solr][:path] = "/opt/solr"
default[:solr][:url] = "http://192.168.2.145:8080/solr-4.2.0.tgz"
default[:solr_core][:url] = "https://github.com/darron/solr-nutch-core/archive/master.zip"

default[:nutch][:prefix] = "/opt"
default[:nutch][:path] = "/opt/nutch"
default[:nutch][:url] = "http://192.168.2.145:8080/apache-nutch-1.6-bin.tar.gz"