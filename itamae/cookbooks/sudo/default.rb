if node[:"use_package"]
  package "sudo" do
    action :install
  end
elsif node[:"use_portage"]
  portage "app-admin/sudo" do
    action :install
  end
end

remote_file '/etc/sudoers' do
  owner 'root'
  group 'root'
  mode '400'
end
