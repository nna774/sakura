link "/etc/localtime" do
  to "/usr/share/zoneinfo/Asia/Tokyo"
  link "/etc/localtime"
  force true
end

file "/etc/timezone" do
  content "Asia/Tokyo\n"
end

ntp = 'ntp'
package ntp do
  action :install
end

service ntp do
  action [:enable, :start]
end
