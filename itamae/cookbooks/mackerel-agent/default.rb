if node["use_package"]
  execute "add mackerel-agent repo" do
    command "curl -fsSL https://mackerel.io/assets/files/scripts/setup-yum.sh | sh"
    not_if "test -e /etc/yum.repos.d/mackerel.repo"
  end

  package 'mackerel-agent' do
    action :install
  end
end

%w{
/etc/mackerel-agent
/var/lib/mackerel-agent
}.each do |d|
  directory d do
    action :create
    mode "0644"
    owner "root"
    group "root"
  end
end

api_key = node[:secrets][:"mackerel-apikey"]
template "/etc/mackerel-agent/mackerel-agent.conf" do
  action :create
  mode "0644"
  owner "root"
  group "root"
  variables(api_key: api_key)
  notifies :restart, "service[mackerel-agent]"
end

file "/var/lib/mackerel-agent/id" do
  mode "0644"
  owner "root"
  group "root"
  content node[:secrets]["mackerel-id-#{node[:name]}"]
  notifies :restart, "service[mackerel-agent]"
end

include_cookbook 'mackerel-agent::plugins' if node["use_package"]

service "mackerel-agent" do
  action [ :start, :enable ]
end
