# 
# Cookbook Name:: cognode-mongodb
# Attributes:: default 
# 
# Credit to https://github.com/edelight/chef-mongodb/blob/master/attributes/default.rb
# edelight GmbH
# 

# cluster identifier 
default[:cognode-mongodb][:client_roles] = []
default[:cognode-mongodb][:cluster_name] = nil
default[:cognode-mongodb][:shard_name] = 'default'

default[:cognode-mongodb][:auto_configure][:replicaset] = true
default[:cognode-mongodb][:auto_configure][:sharding] = true

# don't use the node's fqdn, but this url instead; something like 'ec2-x-y-z-z.aws.com' or 'cs1.domain.com' (no port)
# if not provided, will fall back to the FQDN
default[:cognode-mongodb][:configserver_url] = nil

default[:cognode-mongodb][:root_group] = 'root'
default[:cognode-mongodb][:user] = 'mongodb'
default[:cognode-mongodb][:group] = 'mongodb'

default[:cognode-mongodb][:init_dir] = '/etc/init.d'
default[:cognode-mongodb][:init_script_template] = 'redhat-mongodb.init.erb'
default[:cognode-mongodb][:sysconfig_file] = '/etc/default/mongodb'
default[:cognode-mongodb][:sysconfig_file_template] = 'mongodb.sysconfig.erb'
default[:cognode-mongodb][:dbconfig_file_template] = 'mongod.conf.erb'
default[:cognode-mongodb][:dbconfig_file] = '/etc/mongod.conf'

case node['platform_family']
when 'rhel'
  # determine the package name
  # from http://rpm.pbone.net/index.php3?stat=3&limit=1&srodzaj=3&dl=40&search=mongodb
  # verified for RHEL5,6 Fedora 18,19
  default[:cognode-mongodb][:package_name] = 'mongodb-server'
  default[:cognode-mongodb][:sysconfig_file] = '/etc/sysconfig/mongodb'
  default[:cognode-mongodb][:user] = 'mongod'
  default[:cognode-mongodb][:group] = 'mongod'
  default[:cognode-mongodb][:init_script_template] = 'redhat-mongodb.init.erb'
  default[:cognode-mongodb][:default_init_name] = 'mongod'
  default[:cognode-mongodb][:instance_name] = 'mongod'
else 
  Chef::Log.error("Unsupported Platform Family: #{node['platform_family']}")
end


default[:cognode-mongodb][:template_cookbook] = 'cognode-mongodb'
