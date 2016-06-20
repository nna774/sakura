link "/etc/localtime" do
  to "/usr/share/zoneinfo/Asia/Tokyo"
  link "/etc/localtime"
  force true
end

file "/etc/timezone" do
  content "Asia/Tokyo\n"
end

remote_file "/etc/systemd/system/ntpd.service" do
  owner 'root'
  group 'root'
  mode '644'
end

ntp = 'ntp'
package ntp do
  action :install
end

service 'ntpd' do
  action [:enable, :start]
end
