remote_file "/etc/yum.repos.d/mongodb.repo" do
  mode "0644"
  owner "root"
  group "root"
end

package "mongodb-org" do
  action :install
end

service "mongod" do
  action [ :start, :enable ]
end
