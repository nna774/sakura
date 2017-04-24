node.reverse_merge!(host: "yumemi.nna774.net")
node.reverse_merge!(name: "yumemi")
node.reverse_merge!("use_package": true)

package "openssh"

remote_file '/etc/nginx/nginx.conf' do
  mode "0644"
  owner "root"
  group "root"
  notifies :reload, "service[nginx]"
end

service "nginx" do
  action [ :start, :enable ]
end

package "fail2ban"
package "bind-tools" # for dig
service "fail2ban" do
  action [ :start, :enable ]
end

files = %w(/etc/fail2ban/jail.local /etc/fail2ban/action.d/slack.conf)
files.each do |file|
  remote_file file do
    mode "0644"
    owner "root"
    group "root"
    notifies :reload, "service[fail2ban]"
  end
end

fail2ban_slack_wh_uri = node[:secrets][:"sakura-slack-wh-uri"]
slack_icon_uris = %w(
https://pbs.twimg.com/media/BhFKgEDCQAA7ZGK.jpg
https://pbs.twimg.com/media/BeWJQSuCIAAN4ls.jpg
https://pbs.twimg.com/media/BdsvbA-CYAAjw3_.jpg
https://pbs.twimg.com/media/BcbTiKDCMAEwKik.jpg
https://pbs.twimg.com/media/BhEDeAkCMAAXfnM.jpg
https://pbs.twimg.com/media/Bewe5AdCIAEsz87.jpg
https://pbs.twimg.com/media/Bea8yrACAAAoY74.jpg
https://pbs.twimg.com/media/BdswO_kCIAAt37O.jpg
https://pbs.twimg.com/media/BfPISmkCEAEd4-a.jpg
https://pbs.twimg.com/media/BfPI9daCMAEcBo5.jpg
https://pbs.twimg.com/media/BfPUXivCAAAOhbK.jpg
https://pbs.twimg.com/media/BcFoPS9CUAAsE0e.jpg
).join(' ')
template "/usr/local/bin/fail2ban_slack.sh" do
  action :create
  mode "0755"
  owner "root"
  group "root"
  variables(fail2ban_slack_wh_uri: fail2ban_slack_wh_uri, slack_icon_uris: slack_icon_uris, name: node[:name])
end
