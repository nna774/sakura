packages = %w(htop tmux nginx)
packages.each do |p|
  package p do
    action :install
  end
end
