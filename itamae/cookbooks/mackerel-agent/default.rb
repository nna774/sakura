execute "add mackerel-agent apt repo" do
  command "curl -fsSL https://mackerel.io/assets/files/scripts/setup-apt.sh | sh"
  not_if "test -e /etc/apt/sources.list.d/mackerel.list"
end

package 'mackerel-agent' do
  action :install
end

api_key = node[:secrets][:"mackerel-apikey"]
execute "add api key" do
  command "echo 'apikey = \"#{api_key}\"' >> /etc/mackerel-agent/mackerel-agent.conf"
  not_if "grep #{api_key} /etc/mackerel-agent/mackerel-agent.conf"
end

file "/var/lib/mackerel-agent/id" do
  mode "0644"
  owner "root"
  group "root"
  content node[:secrets][:"mackerel-id"]
end

service "mackerel-agent" do
  action [ :start, :enable ]
end
