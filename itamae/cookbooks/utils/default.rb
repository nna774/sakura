packages = %w(zsh tmux git less nkf dnsutils wget build-essential command-not-found w3m bash-completion man-db htop nano)
packages.each do |package|
  package package do
    action :install
  end
end
