name             'cognode-mongodb'
maintainer       'Farye Nwede'
maintainer_email 'FNwede@cogility.com'
license          'All rights reserved'
description      'Installs/Configures cognode-mongodb'
long_description 'Installs/Configures cognode-mongodb'
version          '0.1.0'

recipe 'cognode-mongodb', 'Installs/Configures cognode-mongodb'

%w(redhat).each do |os|
	supports os
end

attribute 'cognode-mongodb/config/dbpath', 
	:display_name => 'dbpath', 
	:description => 'Path to store the mongodb data', 
	:default => '/data/db'

attribute 'cognode-mongodb/config/logpath', 
	:display_name => 'logpath', 
	:description => 'Path to store the logfiles of a mongodb instance',
	:default => '/var/log/mongodb/mongodb.log'

attribute 'cognode-mongodb/config/port', 
	:display_name => 'Port',
	:description => 'Port the mongodb instance is running on', 
	:default => '27017'

attribute 'cognode-mongodb/reload_action',
	:display_name => 'Reload',
	:description => 'Action to take when MongoDB config files are modified',
	:default => 'restart'

attribute 'cognode-mongodb/cluster_name', 
	:display_name => 'Cluster Name',
	:description => 'Name of the mongodb cluster, all nodes of a cluster must have the same name.', 
	:default => ''
