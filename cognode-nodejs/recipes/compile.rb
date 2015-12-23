ENV['COGMODHOME'] = '/opt/cogility/CogilityNode/FrontEnd'
ENV['COGMGRHOME'] = '/opt/cogility/CogilityNode/Runtime'
ENV['COGPRJHOME'] = '/opt/cogility/Engagements'
ENV['COGJDKHOME'] = '/opt/java'

execute 'compile_cogility_node' do
        cwd '/opt/cogility/CogilityNode/Common'
        command './compile-all.pl master=yes'
end

execute 'npm_install_cogility_runtime' do
	cwd '/opt/cogility/CogilityNode/Runtime'
	command 'npm install'
end

execute 'npm_install_cogility_insight' do 
	cwd '/opt/cogility/CogilityNode/Insight'
	command 'npm install'
end
