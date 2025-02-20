#! /bin/bash
rm ./blacklist.txt
ogroup_id="$(pmgsh get /config/ruledb/who | jq '.[] | select(.name=="AutoBlacklist")  | .id')"
if [ -z "${ogroup_id}" ]; then
    echo "ogroup_id cannot be found"
    exit 1
fi
handle_error() {
    local user="$1"
    #your notificator script here, like:
    #./push_notification --title "PMG Autolist error" --description "Check users  $user  blacklist - there is an error during list creation" --color "0xFF0000"
    #or:
    #echo "ERROR: "$user "there is an error during list creation" >> blacklist_log.txt
}
pmgsh get quarantine/quarusers | jq .[].mail | grep -v "*@" | tr -d '"' | while read user
do
  pmgsh get /quarantine/blacklist -pmail $user | jq .[].address | tr -d '"' | while read address
  do
    try="$(pmgsh create /config/ruledb/who/$ogroup_id/email --email $address)"
    if [[ $? -eq 0 ]]; then
        pmgsh delete /quarantine/blacklist -pmail $user -address $address
      else
        handle_error "$user"
    fi
  done
done
