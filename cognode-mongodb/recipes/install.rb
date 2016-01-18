#
# Cookbook Name:: cognode-mongodb
# Recipe:: default
#
# Copyright (C) 2015 Farye Nwede
#
# All rights reserved - Do Not Redistribute
#
['mongodb-org-server-3.0.7-1.el7.x86_64.rpm', 'mongodb-org-shell-3.0.7-1.el7.x86_64.rpm', 'mongodb-org-tools-3.0.7-1.el7.x86_64.rpm'].each do |p|
#['mongodb-enterprise-server-3.0.7-1.el7.x86_64.rpm', 'mongodb-enterprise-shell-3.0.7-1.el7.x86_64.rpm', 'mongodb-enterprise-tools-3.0.7-1.el7.x86_64.rpm'].each do |p| 
# start from an array of packages, could be an attributes like node['my_namespace']['packages']
	rpm_package p do # no need to do interpolation here, we just need the name
		source "/tmp/#{p}" # Here we have to concatenate path and name
		action :nothing # do nothing, just define the resource
	end

	cookbook_file "/tmp/#{p}" do # I prefer setting the destination in the name
		source p				# and tell the source name, so in case of different platfom I can take advantage of the resolution of files withint the cookbook tree
		mode '0775'
		action :create 
		notifies :install, "rpm_package[#{p}]", :immediately
	end
end

directory node['cognode_mongodb']['config']['dbpath'] do
	owner node['cognode_mongodb']['user']
	group node['cognode_mongodb']['group']
	mode '0755'
	action :create
end

# just-in-case config file drop
template node['cognode_mongodb']['dbconfig_file'] do
  cookbook node['cognode_mongodb']['template_cookbook']
  source node['cognode_mongodb']['dbconfig_file_template']
  group node['cognode_mongodb']['root_group']
  owner 'root'
  mode 0644
  variables(
    :config => node['cognode_mongodb']['config']
  )
  action :create
  notifies :run, 'execute[chown_dependencies]', :immediately
end

template '/etc/init.d/mongod' do
  cookbook node['cognode_mongodb']['template_cookbook']
  source 'mongod.initd.erb'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

execute 'chown_dependencies' do 
	cwd '/'
	command 'chown -R mongod:mongod /data && chown -R mongod:mongod /var/run/mongodb && chown -R mongod:mongod /var/log/mongodb && echo \'OPTIONS="-f /etc/mongod.conf"\' > /etc/sysconfig/mongod'
	action :nothing
end
