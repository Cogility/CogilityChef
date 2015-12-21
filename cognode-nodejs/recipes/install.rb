#
# Cookbook Name:: cognode-nodejs
# Recipe:: install
#
# Copyright (C) 2015 Farye Nwede
#
# All rights reserved - Do Not Redistribute
#

remote_file '/tmp/cogility_node.tar.gz' do 
	source 'https://s3-us-west-1.amazonaws.com/cogility-builds/cogilitynode/cogility_node_latest.tar.gz'
	owner node['cognode_nodejs']['user']
	group node['cognode_nodejs']['group']
	mode '0755'
	action :create
end 

execute 'extract_cognode_repo' do 
	cwd node['cognode_nodejs']['cogility_directory']
	command 'tar xzvf /tmp/cogility_node.tar.gz'
	creates node['cognode_nodejs']['cogilitynode_directory']
end 

directory node['cognode_nodejs']['engagements_directory'] do
	owner node['cognode_nodejs']['user']
	group node['cognode_nodejs']['group']
	mode '0755'
	action :create
end

yum_package 'wget' do
	action :install
	notifies :run, 'execute[install_java_8]', :immediately
end

execute 'install_java_8' do
	cwd node['cognode_nodejs']['java_install_dir']
	command 'wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.tar.gz" && tar xzf jdk-8u60-linux-x64.tar.gz && ln -s jdk-8u60-linux-x64 java'
	creates node['cognode_nodejs']['java_home']
	action :nothing
end

cookbook_file "/tmp/java_variables.conf" do
	source "java_variables.conf"
	notifies :run, 'bash[append_to_root_bash]', :immediately
end 

bash "append_to_root_bash" do
	user "root"
	code <<-EOF
		cat /tmp/java_variables.conf >> /root/.bashrc
	EOF
	not_if "grep -q JAVA_HOME /root/.bashrc"
	notifies :run, 'bash[append_to_ec2_bash]', :immediately
	action :nothing
end

bash "append_to_ec2_bash" do
	user "ec2-user"
	code <<-EOF
		cat /tmp/java_variables.conf >> /home/ec2-user/.bashrc
		rm /tmp/java_variables.conf
	EOF
	not_if "grep -q JAVA_HOME /home/ec2-user/.bashrc"
	action :nothing
end

execute 'install_nodemon' do 
	cwd '/'
	command 'npm install nodemon -g' 
	user 'root'
end
