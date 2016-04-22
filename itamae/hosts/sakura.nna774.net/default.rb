node.reverse_merge!(host: "sakura.nna774.net")
node.reverse_merge!(debian_release: 'wheezy')
node.reverse_merge!(iptables: {
                      open_ports: [22, 80, 443],
                    })

include_role 'base'

include_cookbook 'utils'
include_cookbook 'hostname'
include_cookbook 'backports'
include_cookbook 'nginx'
include_cookbook 'iptables'
