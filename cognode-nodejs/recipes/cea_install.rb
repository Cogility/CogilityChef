remote_file '/tmp/cea_node.tar.gz' do
        source 'https://s3-us-west-1.amazonaws.com/cogility-builds/cea/cea-devel_latest.tar.gz'
        owner node['cognode_nodejs']['user']
        group node['cognode_nodejs']['group']
        mode '0755'
        action :create
end

execute 'extract_cea_repo' do
        cwd '/opt/cogility/Engagements'
        command 'tar xzvf /tmp/cea_node.tar.gz && mv /opt/cogility/Engagements/tmp/CEA/ /opt/cogility/Engagements/CEA && rm -rf /opt/cogility/Engagements/tmp'
        creates '/opt/cogility/Engagements/CEA'
end

execute 'npm_install_cea' do 
	cwd '/opt/cogility/Engagements/CEA'
	command 'npm install'
end

bash "update_mongo_path" do
	user "root"
	code <<-EOF
		sed -i -e '/.*"mongoURI".*/a\ "passportMongoURI": "mongodb:\/\/opacus\/passport_local_mongoose",' /opt/cogility/Engagements/CEA/Config/development.json
		sed -i 's/localhost/opacus/' /opt/cogility/Engagements/CEA/Config/development.json
		sed -i -e '/.*"mongoURI".*/a\ "passportMongoURI": "mongodb:\/\/opacus\/passport_local_mongoose",' /opt/cogility/Engagements/CEA/Config/default.json
		sed -i 's/localhost/opacus/' /opt/cogility/Engagements/CEA/Config/default.json
		sed -i -e '/.*"mongoURI".*/a\ "passportMongoURI": "mongodb:\/\/opacus\/passport_local_mongoose",' /opt/cogility/CogilityNode/Runtime/config/default.json
		sed -i 's/localhost/opacus/' /opt/cogility/CogilityNode/Runtime/config/default.json
		sed -i -e '/.*"mongoURI".*/a\ "passportMongoURI": "mongodb:\/\/opacus\/passport_local_mongoose",' /opt/cogility/CogilityNode/Runtime/config/development.json
		sed -i 's/localhost/opacus/' /opt/cogility/CogilityNode/Runtime/config/development.json
	EOF
	cwd '/opt/cogility'
	action :run
end

template '/etc/init.d/ceanode' do 
	cookbook 'cognode-nodejs'
	source 'ceanode.initd.erb'
	user 'root'
	group 'root'
	mode 0755
	action :create
	notifies :run, "execute[install_cea_initd]", :immediately
end

execute "install_cea_initd" do
	cwd '/etc/init.d'
	command '/usr/local/bin/npm install nodemon -g; chkconfig ceanode --level 35 on && systemctl daemon-reload'
	user 'root'
	action :nothing
end
