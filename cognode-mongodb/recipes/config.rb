#
# Cookbook Name:: cognode-mongodb
# Recipe:: config
#
# Copyright (C) 2015 Farye Nwede
#
# All rights reserved - Do Not Redistribute
#

execute 'restart_mongo' do 
	cwd '/'
	command 'if [[ $(ps axu | grep mongo | grep -v grep) ]]; then mongod --shutdown; fi; sleep 10; rm -f /var/run/mongodb/mongodb.pid; rm -f /var/lock/subsys/mongod; chown -R mongod:mongod /data/db; chown -R monogd:mongod /var/log/mongodb; chown -R monogd:mongod /var/run/mongodb; service mongod start' 
	user 'root'
	action :run
end

template '/tmp/firstuser.js' do
	cookbook node['cognode_mongodb']['template_cookbook']
	source node['cognode_mongodb']['dbuser_template'] 
	user node['cognode_mongodb']['user']
	group node['cognode_mongodb']['group']
	mode 0644
	action :create	
	notifies :run, "execute[config_cea]", :immediately
end

execute 'config_cea' do
	cwd '/tmp'
	command 'if [ -z "$(ps axu | grep mongo)" ]; then mongo cea /tmp/firstuser.js; fi'
	action :nothing
end
