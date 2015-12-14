#
# Cookbook Name:: cognode-nginx
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

service "nginx" do
	action :stop
end 

file "/etc/nginx/nginx.conf" do
	action :delete
end

template "/etc/nginx/nginx.conf" do 
	source "nginx.erb"
	owner "root"
	group "root"
	mode "0755"
end

service "nginx" do
	supports :status => true, :restart => true, :reload => true	
end

directory '/opt/cogility' do
	owner 'ec2-user'
	group 'ec2-user'
	mode '0755'
	action :create
end

remote_file '/opt/cogility/ceaui-static.tar.gz' do
	source 'https://s3-us-west-1.amazonaws.com/cogility-builds/ceaui/ceaui-static.latest.tar.gz'
	owner 'ec2-user'
	group 'ec2-user'
	mode '0755'
	action :create
	notifies :run, 'execute[extract_ceaui]', :immediately
end

execute 'extract_ceaui' do
	command 'cd /opt/cogility && tar xvzf ceaui-static.tar.gz && mv dist ceaui'
	creates '/opt/cogility/ceaui'
	action :nothing
end
