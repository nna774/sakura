ssh = 'ssh'
package ssh do
  action :install
end

service ssh do
  action [:enable, :start]
end
