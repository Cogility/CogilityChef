# Recipe for cogility related stuff
directory node['cognode-nodejs']['cogility_directory] do
	owner node['cognode-nodejs']['user']
	group node['cognode-nodejs']['group']
	mode '0755'
	action :create
end
