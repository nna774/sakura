packages = %w(sudo)
packages.each do |package|
  if node[:"use_package"]
    package package do
      action :install
    end
  else if node[:"use_portage"]
    portage package do
      action :install
    end
  end
end

remote_file '/etc/sudoers' do
  owner 'root'
  group 'root'
  mode '400'
end
