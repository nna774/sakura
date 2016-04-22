ssh = node[:sshd]
package ssh do
  action :install
end

service 'sshd' do
  action [:enable, :start]
end
