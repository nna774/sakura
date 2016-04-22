# coding: utf-8
directory "/opt" do
  action :create
  mode "0755"
  owner "root"
  group "root"
end

package 'git' do
  action :install
end

git "lets encrypt" do
  action :sync
  repository "https://github.com/letsencrypt/letsencrypt"
  cwd "/opt"
  destination "/opt/letsencrypt"
  user "root"
end
