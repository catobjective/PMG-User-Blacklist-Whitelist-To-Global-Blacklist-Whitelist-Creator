
# PMG-User-Blacklist-Whitelist-To-Global-Blacklist-Whitelist-Creator

Simple bash scripts to merge all entries from all User blacklists / whitelists addresses and supply them to the global "Who" object blacklist / whitelist.

This allows entries in individual users lists to protect all users of the server.

It also speeds up blocking email addresses for the entire server from the Spam Quarantine view. Clicking blacklist / whitelist in the Spam Quarantine view adds the sender's address to the blacklist of the specific email recipient. This tool makes these addresses added to the global "Who" object blacklist / whitelist. 


## How it works:

#### Abstract
Proxmox Mail Gateway provides blacklists / whitelists for each user separately. These lists are supplemented, for example, using the blacklist / whitelist buttons in the Spam Quarantine view. Additionally, these per-user lists can be created by users themselves.

Based on the fact that entries on the above-mentioned lists can be used to block / allow emails for all server clients, this tool copies these entries from individual lists and adds them to the Who Mail Filter object list.

### Workflow example
1. Icoming mail is recognized as Spam. Mail is delivered to Spam Quarantine. 
2. The administrator reviews the list of quarantined emails. Based on his own assessment, administrator clicks the Whitelist/Blacklist button. 
3. Sender address is added to ricipient (user) Whtelist/Blacklist. 
4. Only this specific ricipent (user) is affected by this Whitelist/Blacklist entry. 
5. Described script scraps all Whitelisted/Blacklisted emails for all ricipents (users) and supply them to AutoWhitlist and AutoBlacklist WHO list of Mail Filter. 
6. Administrator can create Mail Filter rule to check sender address agains AutoWhitelist/AutoBlacklist and apply or block incoming email. 
7. All ricipents are affected by Mail Filter rule checking AutoWhitelist/Autoblacklist lists supplied with data from individual users whitelists/blacklists scraped by 


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
