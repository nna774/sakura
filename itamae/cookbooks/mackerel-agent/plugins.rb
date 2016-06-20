version = node[:"mackerel-agent"][:"plugin-version"]

# /etc/yum.repos.d/mackerel.repo を置いて yum install したらいいんでは。

package "https://github.com/mackerelio/mackerel-agent-plugins/releases/download/v#{version}/mackerel-agent-plugins-#{version}-1.x86_64.rpm" do
  action :install
  not_if "true"
#  not_if "VER=$(yum list mackerel-agent-plugins | grep mackerel-agent-plugins | head -n1 | cut -f2 -d' '); [ \"x$VER\" == \"x#{version}-1\" ]"
end

package "mackerel-check-plugins" do
  action :install
end
