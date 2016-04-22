template "/etc/hostname" do
  action :create
  mode "0644"
  owner "root"
  group "root"
  variables(host: node[:host])
end
