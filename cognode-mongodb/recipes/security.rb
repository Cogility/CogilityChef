execute 'configure_selinux' do 
	command 'if [ -z "$(semanage port --list | grep 27017)" ]; then semanage port -a -t mongod_port_t -p tcp 27017; fi'
	user 'root'
	group 'root'
	action :run
end

execute 'configure_selinux_directory' do
	command 'sudo chcon -Rv --type=mongod_var_lib_t /data'
	cwd '/data'
	user 'ec2-user'
	group 'ec2-user'
	action :run
end
