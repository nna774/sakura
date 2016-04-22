node.reverse_merge!(host: "sakura.nna774.net")
node.reverse_merge!(debian_release: 'wheezy')

include_role 'base'

include_cookbook 'utils'
include_cookbook 'hostname'
include_cookbook 'backports'
