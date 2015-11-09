service "nginx" do
	action :stop
end 

file "/etc/nginx/nginx.conf" do
	action :delete
end

cookfile_file "/etc/nginx/nginx.conf" do
	source "nginx.conf"
	action :create
end

service "nginx" do
	action :start
end

directory '/opt/cogility' do
	owner 'ec2-user'
	group 'ec2-user'
	mode '0755'
	action :create
end

remote_file '/opt/cogility/ceaui-static.tar.gz' do
	source 'https://s3-us-west-1.amazonaws.com/cogility-builds/ceaui/ceaui-static.latest.tar.gz'
	owner 'ec2-user'
	group 'ec2-user'
	mode '0755'
	action :create	
end
