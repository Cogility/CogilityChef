remote_file '/tmp/cea_node.tar.gz' do
        source 'https://s3-us-west-1.amazonaws.com/cogility-builds/cea/cea-devel_latest.tar.gz'
        owner node['cognode_nodejs']['user']
        group node['cognode_nodejs']['group']
        mode '0755'
        action :create
end
