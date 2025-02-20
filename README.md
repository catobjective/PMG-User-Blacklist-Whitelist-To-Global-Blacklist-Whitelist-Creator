# PMG-User-Blacklist-Whitelist-To-Global-Blacklist-Whitelist-Creator

It's just moved addresses from users blacklists/whitelists to WHO object. Blocked for one user is now blocket for whole server!

Simple bash scripts to merge all entries from all user blacklists/whitelists and supply them to the global "Who" object blacklist/whitelist.

This allows entries in individual users' lists to protect all users of the server.

It also speeds up blocking email addresses for the entire server from the Spam Quarantine view. Clicking blacklist/whitelist in the Spam Quarantine view adds the sender's address to the blacklist of the specific email recipient. This tool ensures these addresses are added to the global "Who" object blacklist/whitelist.

## How it works:

### Abstract
Proxmox Mail Gateway provides blacklists/whitelists for each user separately. These lists are supplemented, for example, using the blacklist/whitelist buttons in the Spam Quarantine view. Additionally, these per-user lists can be created by users themselves.

Based on the fact that entries on the above-mentioned lists can be used to block/allow emails for all server clients, this tool copies these entries from individual lists and adds them to the "Who" Mail Filter object list.

### Workflow example
1. Incoming mail is recognized as spam. Mail is delivered to Spam Quarantine.  
2. The administrator reviews the list of quarantined emails. Based on their own assessment, the administrator clicks the Whitelist/Blacklist button.  
3. The sender's address is added to the recipient's (user's) whitelist/blacklist.  
4. Only this specific recipient (user) is affected by this whitelist/blacklist entry.
5. After running script address record is supplied to Autoblacklist WHO object.
6. Action can be created to block emails incoming from addresses listed on Autoblacklist. 

## Deployment

Download files updateWhitelist.sh and updateBlacklist.sh to your Proxmox Mail Gateway server instance. 

Prepare Proxmox Mail Gateway WHO object list for blacklist and whitelist. Create two lists named:
```bash
  AutoWhitelist
```
and 
```bash
  AutoBlacklist
```

Run manually script updateWhitelist.sh to update AutoWhitelist or updateBlacklist.sh to update AutoBlacklist. 

```bash
  ./updateWhitelist.sh
  ./updateBlacklist.sh
```
You can run those commands automatically, eg. with Crontab:

```bash
  crontab -e
  10 * * * * /updateWhitelist.sh
  20 * * * * /updateBlacklist.sh
```

To clear entries from AutoWhitelist or AutoBlacklist use PMG WEB GUI. You can also delete whole WHO list and create another one with the same name. 

## Requirements
* bash
* jq package
* working PMG instance
* shell access to PMG instance server.
