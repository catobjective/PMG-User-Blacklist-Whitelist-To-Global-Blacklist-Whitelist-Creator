#! /bin/bash
set -e
ogroup_id="$(pmgsh get /config/ruledb/who | jq '.[] | select(.name=="AutoWhitelist")  | .id')"
if [ -z "${ogroup_id}" ]; then
    echo "ogroup_id cannot be found"
    exit 1
fi

pmgsh get quarantine/quarusers | jq .[].mail | grep -v "*@" | tr -d '"' | while read user
do
  pmgsh get /quarantine/whitelist -pmail $user | jq .[].address | tr -d '"' | while read address
  do
    pmgsh create /config/ruledb/who/$ogroup_id/email --email $address
  done
done
