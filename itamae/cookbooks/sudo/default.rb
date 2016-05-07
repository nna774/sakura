packages = %w(sudo)
packages.each do |package|
  package package do
    action :install
  end
end

remote_file '/etc/sudoers' do
  owner 'root'
  group 'root'
  mode '400'
end
