template "/tmp/ldapconfig.ldif" do
	   source "slapd-config.ldif.erb"
end


execute "slapdlog" do
	command "echo \"local4.*\     /var/log/openldap.log\" >/etc/rsyslog.d/ldap.conf"
end

service "rsyslog" do
	action :restart
end

service "slapd" do
	action [ :enable, :start ]
end


execute "configure ldap" do 
	command "sleep 5;ldapmodify -Y EXTERNAL -H ldapi:/// </tmp/configmaindb.ldif"
end

execute "logrotate_ldap" do
	command "sed -i '1i/var/log/openldap.log' /etc/logrotate.d/syslog"
end
