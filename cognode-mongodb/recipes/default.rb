#
# Cookbook Name:: cognode-mongodb
# Recipe:: default
#
# Copyright (C) 2015 Farye Nwede
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'cognode-mongodb::prerequisites'
include_recipe 'cognode-mongodb::cogility'
include_recipe 'cognode-mongodb::install'
