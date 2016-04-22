packages = %w(sudo)
packages.each do |package|
  package package do
    action :install
  end
end
