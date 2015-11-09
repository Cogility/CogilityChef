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
