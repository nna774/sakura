node.reverse_merge!(host: "sakura.nna774.net")
node.reverse_merge!(name: "sakura")
#node.reverse_merge!(debian_release: 'wheezy')
node.reverse_merge!(iptables: {
                      open_ports: [22, 25, 80, 110, 143, 443], # 110 and 143 for tor
                    })
node.reverse_merge!(sshd: "openssh-server")

node.reverse_merge!("mackerel-agent": {
                      "plugin-version": "0.19.4"
                    })

node.reverse_merge!(dns: {
                      servers: %w(8.8.8.8 8.8.4.4),
                    })

node.reverse_merge!("use_package": true)

node.reverse_merge!(utils:{ packages: %w(epel-release gcc-c++ bind-utils)})

node.reverse_merge!(nona: {
                      authorized_keys: [
                        "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAmIet5NxOTogk52tPSIe8QwIR9FEgnNi8euSfH1LUESIn9msJ6tGn0boCTS4SS9Al7EyE03PYq2DRgpia0u/puHFFjnrEhw/rGGeduIXBrF/1jlavqxtZSFWv7h/Ll4vd9EfW5aW9fIkBHm9s+tPkCYUuefN9nimtTC2oPntyA7C9eg8/D/Hvhnp9aBQSUYJYZYDVw4cIHhwRcvO98cg28Cp/WI3Cq6ObGVIUjrqeQxqX0APyiw+n6ulDhCqGJxlkcih02TjNsrWE37xQHGEscygOF0s8j80oIm2lXiEE8OyK6s/XxsEx4mDp2vlpJGQR/2Hx9Cobc2QssNWqaanM5w== ikaduchi-20151007",
                        "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAuSWaN5ZkzTLJDgliJbctzQJZhvwUPoeAjALmS2bkhymhcCFNXVU6HvsBG9LSqFgl1ghZV7Jx/oEjicaepnSC71zyr/TcIckSrp4HjNVoFqjuwUdZmC9raAvBYnoa23uvmzIQfnfWgF9fh2mGQ6pkQICvljF/nyNif2p+HN5rWSYn1s52+Bn7Sqmba1Ncxm9F/Q58l0BICRjt4QdbXSRrqGWLtPbNv+wIDdLoqrojHUcrV4Yg1J3QxdH5dpChFhE5PLRrK0Ldz9SEYg6oE7cMuew9YPv3teRLiMNwwGAUUEA8q99ur82kUs4GiGJFMOzlIwp/g+sR79TbKajhPG3Lvw== nona@tsukumothan-2016-11-14",
                        'permitopen="localhost:25",command="/bin/true",no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDE6U/7+MlTQt6WmimeiPe1TeMlcBNrZqg+wolEPUhqeXjEE7wtbQpesHh5hKaSahQ6fpZp+rpbw3BTyp2J9EqXkdsVKXGWULtEH/we2K++pViacexVny3FvLJHk6a3kcDImAtsojnwW08cTQPeqghkSRbeczuUQXByrF6qf1H8W3fCMSyzpgkds1/rAdqmktiRc+N/De0ken/xn3j+b8O0hL7BWhPkavh9CNuTbgS9Y8zRZ7IwP268cIbpTuYpdldjzrNptFMfOqIRajFEaP1e34pRLq2RtMGKeB0o3qbMMXkw5R5Saw+M9X14JKYqvKfnuLRyYondn68+LHNRivi5 root@ushio.nna774.net', # ssh port forward settings between ushio, for mail
                      ],
                      include_default_authorized_keys: false,
                    })

include_role 'base'

include_cookbook 'utils'
include_cookbook 'hostname'
#include_cookbook 'backports'
include_cookbook 'nginx'
include_cookbook 'iptables'
include_cookbook 'mackerel-agent'
include_cookbook 'letsencrypt'
include_cookbook 'postfix'
include_cookbook 'cron'
include_cookbook 'tor'
include_cookbook 'fail2ban'
include_cookbook 'mongodb'

[
  '/etc/systemd/system/certbot-renew.service',
  '/etc/systemd/system/certbot-renew.timer'
].each do |f|
  file f do
    mode "0644"
    owner "root"
    group "root"
  end
end
