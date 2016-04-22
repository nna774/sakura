package 'epel-release' do
  action :install
end

packages = %w(zsh tmux git less wget gcc w3m bash-completion man-db htop nano)
packages.each do |package|
  package package do
    action :install
  end
end
