include_cookbook 'sudo'

DEFAULT_AUTHORIZED_KEYS = [
  "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAmIet5NxOTogk52tPSIe8QwIR9FEgnNi8euSfH1LUESIn9msJ6tGn0boCTS4SS9Al7EyE03PYq2DRgpia0u/puHFFjnrEhw/rGGeduIXBrF/1jlavqxtZSFWv7h/Ll4vd9EfW5aW9fIkBHm9s+tPkCYUuefN9nimtTC2oPntyA7C9eg8/D/Hvhnp9aBQSUYJYZYDVw4cIHhwRcvO98cg28Cp/WI3Cq6ObGVIUjrqeQxqX0APyiw+n6ulDhCqGJxlkcih02TjNsrWE37xQHGEscygOF0s8j80oIm2lXiEE8OyK6s/XxsEx4mDp2vlpJGQR/2Hx9Cobc2QssNWqaanM5w== ikaduchi-20151007",
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
