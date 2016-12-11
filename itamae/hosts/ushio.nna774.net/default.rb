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
net-fs/nfs-utils
app-shells/zsh
www-servers/nginx
sys-fs/btrfs-progs
app-portage/eix
net-misc/telnet-bsd
net-im/ejabberd
app-crypt/certbot
net-analyzer/traceroute
app-i18n/nkf
app-portage/repoman
net-ftp/tftp-hpa
media-gfx/imagemagick
}.each do |p|
  portage p do
  end
end

#service "sshd" do
#  action :enable
#end

portage "net-misc/autossh" do
end

%w{
/etc/systemd/network/09-br0.netdev
/etc/systemd/network/10-static.network
/etc/systemd/network/11-static.network
}.each do |f|
  remote_file f do
    mode "0644"
    owner "root"
    group "root"
  end
end

service "systemd-networkd" do
  action [ :start, :enable ]
end

include_cookbook 'fail2ban'

# timers
%w{
update-ddns
emerge-sync
}.each do |t|
  remote_file "/etc/systemd/system/#{t}.service" do
    mode "0644"
    owner "root"
    group "root"
  end
  remote_file "/etc/systemd/system/#{t}.timer" do
    mode "0644"
    owner "root"
    group "root"
  end
  service "#{t}.timer" do
    action [ :start, :enable ]
  end
end

portage "net-dns/unbound"
%w{
/etc/unbound/unbound.conf
/etc/unbound/nna774.net.conf
}.each do |f|
  remote_file f do
    mode "0644"
    owner "root"
    group "root"
  end
end
execute "get root.hint" do
  command "curl -o /etc/unbound/root.hints https://www.internic.net/domain/named.cache"
  not_if "test -e /etc/unbound/root.hints"
end
file "/etc/unbound/root-anchors.txt" do
  content ". IN DS 19036 8 2 49AAC11D7B6F6446702E54A1607371607A1A41855200FD2CE1CDDE32F24E8FB5\n"
  mode "0644"
  owner "root"
  group "root"
  not_if "test -e /etc/unbound/root-anchors.txt"
end
service "unbound" do
  action [ :start, :enable ]
end

include_cookbook "mackerel-agent"

%w{
/etc/portage/repos.conf
}.each do |d|
  directory d
end
git "/usr/local/portage" do
  repository "git@github.com:nna774/myOverlay.git"
  revision "master"
end
execute "set owner" do
  command "chown -R portage:portage /usr/local/portage"
end
remote_file "/etc/portage/repos.conf/local.conf"
