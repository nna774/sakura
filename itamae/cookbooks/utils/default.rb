package 'epel-release' do
  action :install
end

packages = %w(zsh tmux git less wget gcc gcc-c++ make w3m bash-completion man-db htop nano which)
packages.each do |package|
  package package do
    action :install
  end
end
