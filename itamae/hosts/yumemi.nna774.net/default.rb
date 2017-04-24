node.reverse_merge!(host: "yumemi.nna774.net")
node.reverse_merge!(name: "yumemi")
node.reverse_merge!("use_package": true)

package "openssh"

remote_file '/etc/nginx/nginx.conf' do
  mode "0644"
  owner "root"
  group "root"
  notifies :reload, "service[nginx]"
end

service "nginx" do
  action [ :start, :enable ]
end

