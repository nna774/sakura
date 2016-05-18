node.reverse_merge!(host: "sakura.nna774.net")
#node.reverse_merge!(debian_release: 'wheezy')
node.reverse_merge!(iptables: {
                      open_ports: [22, 80, 443],
                    })
node.reverse_merge!(sshd: "openssh-server")

node.reverse_merge!("mackerel-agent": {
                      "plugin-version": "0.19.4"
                    })

node.reverse_merge!(dns: {
                      servers: %w(8.8.8.8 8.8.4.4),
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
