template "/tmp/ldapconfig.ldif" do
	   source "slapd-config.ldif.erb"
end

if node['platform'] == "amazon" || node['platform'] == "centos"
	execute "slapdlog" do
		command "echo \"local4.*\     /var/log/openldap.log\" >/etc/rsyslog.d/ldap.conf"
		notifies :restart, "service[rsyslog]", :immediately
	end
	execute "logrotate_ldap" do
		command "sed -i '1i/var/log/openldap.log' /etc/logrotate.d/syslog"
	end
end

service "rsyslog" do
	action :nothing
end

service "slapd" do
	action [ :enable, :start ]
end


execute "configure ldap" do 
	command "sleep 5;ldapmodify -Y EXTERNAL -H ldapi:/// </tmp/ldapconfig.ldif"
end

