#! /bin/sh

IP=$1
NAME=$2
HOST=`dig -x $IP +short`
URIS=(<%= @slack_icon_uris %>)
URI=${URIS[ $RANDOM % ${#URIS[@]} ]}

curl -X POST --data-urlencode "payload={\"channel\": \"#nona-kanshi\",\
                                        \"username\": \"<%= @name %>\",\
                                        \"text\": \"Fail2Ban Reports IP <https://ipinfo.io/$IP|$IP> ($HOST) has been banned by filter $NAME.\",\
                                        \"icon_url\": \"$URI\"}"\
     <%= @fail2ban_slack_wh_uri %>
