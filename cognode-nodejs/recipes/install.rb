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

execute 'install_java_8' do
	cwd node['cognode-nodejs']['java_install_dir']
	command 'wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.tar.gz" && tar xzf jdk-8u60-linux-x64.tar.gz && ln -s jdk-8u60-linux-x64 java'
	creates node['cognode-nodejs']['java_home']
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
	not_if "grep -q JAVA_HOME /home/ec2-user/.bashrc
	action :nothing
end

execute 'install_nodemon' do 
	cwd '/'
	command '
