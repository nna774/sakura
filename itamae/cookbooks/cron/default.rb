package "cronie-noanacron" do
  action :install
end

service "crond" do
  action [ :start, :enable ]
end
