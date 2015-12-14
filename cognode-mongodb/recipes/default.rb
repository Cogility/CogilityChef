#
# Cookbook Name:: cognode-mongodb
# Recipe:: default
#
# Copyright (C) 2015 Farye Nwede
#
# All rights reserved - Do Not Redistribute
#
package 'net-snmp' do
	action :install
	only_if do platform?("redhat") end	
end

package 'cyrus-sasl' do
	action :install
end

package 'cyrus-sasl-plain' do
	action :install
end

package 'cyrus-sasl-gssapi' do
	action :install
end

package 'net-snmp-utils' do 
	action :install
end 

['mongodb-enterprise-server-3.0.7-1.el7.x86_64.rpm', 'mongodb-enterprise-shell-3.0.7-1.el7.x86_64.rpm', 'mongodb-enterprise-tools-3.0.7-1.el7.x86_64.rpm'].each do |p| 
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

directory '/data/db' do
	owner 'mongod'
	group 'mongod'
	mode '0755'
	action :create
end
