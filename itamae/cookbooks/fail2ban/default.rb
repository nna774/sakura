package "jwhois" do
  action :install
end

package "fail2ban" do
  action :install
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
template "/usr/local/bin/fail2ban_slack.sh" do
  action :create
  mode "0755"
  owner "root"
  group "root"
  variables(fail2ban_slack_wh_uri: fail2ban_slack_wh_uri)
end

service "fail2ban" do
  action [ :start, :enable ]
end
