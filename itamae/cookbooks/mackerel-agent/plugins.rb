version = node[:"mackerel-agent"][:"plugin-version"]

package "https://github.com/mackerelio/mackerel-agent-plugins/releases/download/v#{version}/mackerel-agent-plugins-#{version}-1.x86_64.rpm" do
  action :install
  not_if "VER=$(yum list mackerel-agent-plugins | grep mackerel-agent-plugins | head -n1 | cut -f2 -d' '); [ \"x$VER\" == \"x#{version}-1\" ]"
end

conf = "/etc/mackerel-agent/mackerel-agent.conf"
execute "add mackerel-plugin-nginx setting" do
  command <<-EOC
cat <<EOS >> #{conf}
[plugin.metrics.nginx]
command = "mackerel-plugin-nginx -port=10080 -path=/status"
EOS
EOC
  not_if "grep plugin.metrics.nginx #{conf}"
  notifies :restart, "service[mackerel-agent]"
end

