include_cookbook 'ruby'

execute "add nginx repo" do
  command "curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo"
  not_if "test -e  /etc/yum.repos.d/passenger.repo"
end

package "nginx" do
  action :install
end

user "passenger" do
  action :create
  username "passenger"
  home "/home/passenger"
  system_user true
end

directory "/home/passenger" do
  owner "passenger"
  group "passenger"
  mode "755"
end

include_cookbook 'nginx::ci_deploy'

packages = %w(passenger passenger-devel)
packages.each do |package|
  package package do
    action :install
  end
end

git "rbenv" do
  action :sync
  repository "git://github.com/sstephenson/rbenv.git"
  destination "/home/passenger/.rbenv"
  user "passenger"
end

git "rbenv ruby-build" do
  action :sync
  repository "git://github.com/sstephenson/ruby-build.git"
  destination "/home/passenger/.rbenv/plugins/ruby-build"
  user "passenger"
end

package "pygpgme" do
  action :install
end

remote_file "/etc/nginx/nginx.conf" do
  mode "0644"
  owner "root"
  group "root"
  notifies :reload, "service[nginx]"
end

remote_file "/etc/nginx/conf.d/sakura.conf" do
  mode "0644"
  owner "root"
  group "root"
  notifies :reload, "service[nginx]"
end

service "nginx" do
  action [ :start, :enable ]
end
