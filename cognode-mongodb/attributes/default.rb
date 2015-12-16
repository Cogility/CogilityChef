# 
# Cookbook Name:: cognode-mongodb
# Attributes:: default 
# 
# Credit to https://github.com/edelight/chef-mongodb/blob/master/attributes/default.rb
# edelight GmbH
# 

# cluster identifier 
default[:cognode_mongodb][:client_roles] = []
default[:cognode_mongodb][:cluster_name] = nil
default[:cognode_mongodb][:shard_name] = 'default'

default[:cognode_mongodb][:auto_configure][:replicaset] = true
default[:cognode_mongodb][:auto_configure][:sharding] = true

# don't use the node's fqdn, but this url instead; something like 'ec2-x-y-z-z.aws.com' or 'cs1.domain.com' (no port)
# if not provided, will fall back to the FQDN
default[:cognode_mongodb][:configserver_url] = nil

default[:cognode_mongodb][:root_group] = 'root'
default[:cognode_mongodb][:user] = 'mongodb'
default[:cognode_mongodb][:group] = 'mongodb'

default[:cognode_mongodb][:init_dir] = '/etc/init.d'
default[:cognode_mongodb][:init_script_template] = 'redhat-mongodb.init.erb'
default[:cognode_mongodb][:sysconfig_file] = '/etc/default/mongodb'
default[:cognode_mongodb][:sysconfig_file_template] = 'mongodb.sysconfig.erb'
default[:cognode_mongodb][:dbconfig_file_template] = 'mongod.conf.erb'
default[:cognode_mongodb][:dbconfig_file] = '/etc/mongod.conf'

case node['platform_family']
when 'rhel'
  # determine the package name
  # from http://rpm.pbone.net/index.php3?stat=3&limit=1&srodzaj=3&dl=40&search=mongodb
  # verified for RHEL5,6 Fedora 18,19
  default[:cognode_mongodb][:package_name] = 'mongodb-server'
  default[:cognode_mongodb][:sysconfig_file] = '/etc/sysconfig/mongodb'
  default[:cognode_mongodb][:user] = 'mongod'
  default[:cognode_mongodb][:group] = 'mongod'
  default[:cognode_mongodb][:init_script_template] = 'redhat-mongodb.init.erb'
  default[:cognode_mongodb][:default_init_name] = 'mongod'
  default[:cognode_mongodb][:instance_name] = 'mongod'
else 
  Chef::Log.error("Unsupported Platform Family: #{node['platform_family']}")
end


default[:cognode_mongodb][:template_cookbook] = 'cognode-mongodb'
