package "postfix" do
  action :install
end

package "cyrus-sasl-plain" do
  action :install
end

file "/etc/postfix/main.cf" do
  mode "0644"
  owner "root"
  group "root"
  notifies :reload, "service[postfix]"
end

service "postfix" do
  action [ :start, :enable ]
end

service "saslauthd" do
  action [ :start, :enable ]
end
