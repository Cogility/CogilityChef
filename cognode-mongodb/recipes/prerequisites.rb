# Stuff needed before MongoDB installation
package 'net-snmp' do
        action :install
        only_if do platform?("redhat") end     
end

package 'cyrus-sasl' do
        action :install
end

package 'cyrus-sasl-plain' do
        action :install
end

package 'cyrus-sasl-gssapi' do
        action :install
end

package 'net-snmp-utils' do
        action :install
end
