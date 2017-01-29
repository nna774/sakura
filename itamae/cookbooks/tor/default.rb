remote_file "/etc/yum.repos.d/torproject.repo" do
  mode "0644"
  owner "root"
  group "root"
end

package "tor" do
  action :install
end

service "tor" do
  action [ :start, :enable ]
end

remote_file "/etc/tor/torrc" do
  mode "0644"
  owner "root"
  group "root"
  notifies :reload, "service[tor]"
end

directory "/var/lib/tor/hidden_service" do
  owner "toranon"
  group "toranon"
  mode "700"
end

file "/var/lib/tor/hidden_service/private_key" do
  content node[:secrets][:"tor_private_key-j5e4w6u3apivbn44.onion"] + "\n"
  owner "toranon"
  group "toranon"
  mode "600"
end

file "/var/lib/tor/hidden_service/hostname" do
  content "j5e4w6u3apivbn44.onion\n"
  owner "toranon"
  group "toranon"
  mode "600"
end
