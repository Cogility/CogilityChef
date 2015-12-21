# Recipe for cogility related stuff
directory node['cognode_nodejs']['cogility_directory'] do
	owner node['cognode_nodejs']['user']
	group node['cognode_nodejs']['group']
	mode '0755'
	action :create
end
