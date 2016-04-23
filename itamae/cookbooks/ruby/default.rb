packages = %w(patch unzip bzip2 bzip2-devel zlib-devel openssl-devel gdbm-devel libxml2-devel libxslt-devel libffi-devel ruby-devel libcurl-devel readline-devel)
packages.each do |package|
  package package do
    action :install
  end
end
