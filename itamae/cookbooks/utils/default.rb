packages = %w(tmux git less wget gcc make w3m bash-completion man-db htop nano which file nmap)
packages.concat(node.dig(:utils, :packages) || [])

packages.each do |package|
  package package do
    action :install
  end
end
