node.reverse_merge!(host: "sazanami")

include_role 'base'

include_cookbook 'utils'
include_cookbook 'hostname'
include_cookbook 'yaourt'
include_cookbook 'vconsole'
include_cookbook 'grub'
