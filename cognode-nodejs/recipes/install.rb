#
# Cookbook Name:: cognode-nodejs
# Recipe:: install
#
# Copyright (C) 2015 Farye Nwede
#
# All rights reserved - Do Not Redistribute
#

execute 'get_cognode_repo' do
	cwd node['cognode-nodejs']['cogility_directory']
	command 'git clone https://7e0e7ee0251607393b9cd83e338157cd382f0259:x-oauth-basic@github.com/Cogility/CogilityNode.git'
	creates node['cognode-nodejs']['cogilitynode_directory']
end

directory node['cognode-nodejs']['engagements_directory'] do
	owner node['cognode-nodejs']['user']
	group node['cognode-nodejs']['group']
	mode '0755'
	action :create
end
