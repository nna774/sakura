template "/etc/sysconfig/iptables" do
  action :create
  mode "0644"
  owner "root"
  group "root"
  variables(ports: node[:iptables][:open_ports])
end
