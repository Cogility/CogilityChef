#
# Cookbook Name:: cognode-nodejs
# Attributes:: default
# 
# Farye Nwede 
# Copyright Cogility Software 2015
#

default[:cognode_nodejs][:cogility_directory] = '/opt/cogility'
default[:cognode_nodejs][:user] = 'ec2-user'
default[:cognode_nodejs][:group] = 'ec2-user'
default[:cognode_nodejs][:root_group] = 'root'

default[:cognode_nodejs][:cogilitynode_directory] = '/opt/cogility/CogilityNode'
default[:cognode_nodejs][:engagements_directory] = '/opt/cogility/Engagements'

default[:cognode_nodejs][:java_install_dir] = '/opt'
default[:cognode_nodejs][:java_home] = '/opt/java'
