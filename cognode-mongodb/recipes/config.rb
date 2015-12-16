#
# Cookbook Name:: cognode-mongodb
# Recipe:: config
#
# Copyright (C) 2015 Farye Nwede
#
# All rights reserved - Do Not Redistribute
#

template /tmp/firstuser.js do
	cookbook node['cognode_mongodb']['template_cookbook']
	source node['cognode_mongodb']['dbuser_template'] 
	user node['cognode_mongodb']['user']
	group node['cognode_mongodb']['group']
	mode 0644
	action :create	
	notifies :run, "config_cea", :immediately
end

execute 'config_cea' do
	cwd '/tmp'
	command 'mongo cea /tmp/firstuser.js'
	action :nothing
end
