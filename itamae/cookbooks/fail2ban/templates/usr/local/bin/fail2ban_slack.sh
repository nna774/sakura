#! /bin/sh

IP=$1
NAME=$2
HOST=`dig -x $IP PTR | grep -v -e ";" -e "^$" | head -n1 | cut -f5`
URIS=(https://pbs.twimg.com/media/BhFKgEDCQAA7ZGK.jpg https://pbs.twimg.com/media/BeWJQSuCIAAN4ls.jpg https://pbs.twimg.com/media/BdsvbA-CYAAjw3_.jpg https://pbs.twimg.com/media/BcbTiKDCMAEwKik.jpg https://pbs.twimg.com/media/BhEDeAkCMAAXfnM.jpg)
URI=${URIS[ $RANDOM % ${#URIS[@]} ]}

curl -X POST --data-urlencode "payload={\"channel\": \"#nona-kanshi\",\
                                        \"username\": \"sakura\",\
                                        \"text\": \"Fail2Ban Reports IP <https://ipinfo.io/$IP|$IP> ($HOST) has been banned by filter $NAME.\",\
                                        \"icon_url\": \"$URI\"}"\
     <%= @fail2ban_slack_wh_uri %>
