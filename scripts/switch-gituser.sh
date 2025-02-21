#!/bin/bash 
Github_username=$1

if [ -z "${Github_username}" ];then
    echo "Usage: $0 <Github-username>"
    exit 1
fi

# get account details and check whether github user exists or not 
account_info=$(grep -w ${Github_username} config/github_accounts.conf)

if [ -z "${account_info}" ];then
    echo "Error: Account ${Github_username} not found ! "
    exit 1 
fi

function Switchuser()
{
IFS=' ' read -r username alias email <<< "${account_info}"
echo "Switching to GitHub account: $username"
# Switch SSH key
ssh -T "git@$alias"
git config user.name "${Github_username}"
git config user.email "${email}"
echo "Active Git Config: User = $(git config --get user.name), Email = $(git config --get user.email)"
echo "Successfully switched to GitHub account: $username"
}

# main script 
Switchuser

