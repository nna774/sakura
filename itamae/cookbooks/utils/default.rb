package 'epel-release' do
  action :install
end

packages = %w(tmux git less wget gcc gcc-c++ make w3m bash-completion man-db htop nano which file nmap bind-utils)
packages.each do |package|
  package package do
    action :install
  end
end
