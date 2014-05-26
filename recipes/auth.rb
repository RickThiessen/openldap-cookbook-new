if node['platform'] == "centos" || node['platform'] == "amazon"
	execute "auth_config_ldap" do
		command "authconfig --enableldap --enableldapauth --ldapserver=#{node['openldap']['auth_host']} --ldapbasedn=\"#{node['openldap']['auth_basedn']}\" --update"
	end
end
