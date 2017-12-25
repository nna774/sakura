include_cookbook 'sudo'

DEFAULT_AUTHORIZED_KEYS = [
  "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAEYIrOpHsdw23+Fn9aA9ISvIlrx2aUhnZqPHHM28TrxcbT8EWHG5xC3Ge6CNJ13sENPO23xa/QHs1VS2R2DQsMdOgB5oUYVMTSxmoQVXptqXcJkgLtKmWxZzvZPA2fsdfG/yvdyinwZOAx6HJVvoPM4CLXhkVWQuOHdhC61GkIeWWXyqQ== ikaduchi-20170510",
]

node.reverse_merge!(
  nona: {
    sudo: :rootpw,
    authorized_keys: [],
    include_default_authorized_keys: true,
  },
)

group "nona" do
  gid 1000
end

user "nona" do
  uid 1000
  gid 1000
  home "/home/nona"
end

directory "/home/nona" do
  owner "nona"
  group "nona"
  mode "755"
end

directory "/home/nona/.ssh" do
  owner "nona"
  group "nona"
  mode "0700"
end

file "/home/nona/.ssh/authorized_keys" do
  authorized_keys = node[:nona][:authorized_keys]
  if node[:nona][:include_default_authorized_keys]
    authorized_keys.concat DEFAULT_AUTHORIZED_KEYS
  end

  content authorized_keys.join(?\n) + ?\n
  owner "nona"
  group "nona"
  mode "600"
end


if node[:nona][:sudo]
  sudoer = case node[:nona][:sudo]
           when :nopasswd
             "nona ALL=(ALL) NOPASSWD:ALL"
           when :rootpw
             <<-EOF
Defaults:nona rootpw
nona ALL=(ALL) ALL
    EOF
           else
             raise "unknown node[:nona][:sudo] (#{node[:nona][:sudo].inspect})"
           end
end
