#
# Cookbook Name:: cognode-nodejs
# Attributes:: default
# 
# Farye Nwede 
# Copyright Cogility Software 2015
#

default[:cognode-nodejs][:cogility_directory] = '/opt/cogility'
default[:cognode-nodejs][:user] = 'ec2-user'
default[:cognode-nodejs][:group] = 'ec2-user'
default[:cognode-nodejs][:root_group] = 'root'

default[:cognode-nodejs][:cogilitynode_directory] = '/opt/cogility/CogilityNode'
default[:cognode-nodejs][:engagements_directory] = '/opt/cogility/Engagements'
