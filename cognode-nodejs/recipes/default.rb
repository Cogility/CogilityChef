#
# Cookbook Name:: cognode-nodejs
# Recipe:: default
#
# Copyright (C) 2015 Farye Nwede
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'cognode-nodejs::cogility'
include_recipe 'cognode-nodejs::install'
include_recipe 'cognode-nodejs::compile'
include_recipe 'cognode-nodejs::cea_install'
