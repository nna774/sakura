execute "add nginx repo" do
  command "yum install -y http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm"
  not_if "test -e  /etc/yum.repos.d/nginx.repo"
end

package "nginx" do
  action :install
end
