file "/etc/hostname" do
  action :create
  mode "0644"
  owner "root"
  group "root"
  content node[:host] << "\n"
end
