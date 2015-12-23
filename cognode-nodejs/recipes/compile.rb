env 'COGMODHOME' do 
	value '/opt/cogility/CogilityNode/FrontEnd'
end 

env 'COGMGRHOME' do 
	value '/opt/cogility/CogilityNode/Runtime'
end

env 'COGPRJHOME' do
	value '/opt/cogility/Engagements'
end

env 'COGJDKHOME' do 
	value '/opt/java'
end

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
