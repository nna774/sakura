node.reverse_merge!(host: "ushio.nna774.net")
node.reverse_merge!(name: "ushio")
node.reverse_merge!("use_package": false)
node.reverse_merge!("use_portage": true)

%w{
dev-lang/ruby
dev-vcs/git
sys-process/htop
app-misc/tmux
app-shells/bash-completion
sys-kernel/genkernel-next
net-analyzer/nmap
net-dns/bind-tools
app-misc/jq
app-admin/sudo
app-editors/emacs
sys-apps/smartmontools
}.each do |p|
  portage p do
  end
end

#service "sshd" do
#  action :enable
#end

portage "net-misc/autossh" do
end

remote_file "/etc/systemd/network/10-static.network" do
  mode "0644"
  owner "root"
  group "root"
end

include_cookbook 'fail2ban'
