file "/etc/apt/sources.list.d/backports.list" do
  action :create
  mode "0644"
  owner "root"
  group "root"
  content "deb http://ftp.debian.org/debian #{node[:debian_release]}-backports main\n"
end

file "/etc/apt/preferences.d/backports" do
  action :create
  mode "0644"
  owner "root"
  group "root"
  content <<-EOS
Package: *
Pin: release a=#{node[:debian_release]}-backports
Pin-Priority: 600
EOS
end
