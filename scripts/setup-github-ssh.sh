Github_username=$1
email_address=$2
ssh_alias=$3
path=$4


if [ -f "../config/credentials.env" ] 
then 
      source ../config/credentials.env
else    
      echo " Error: config/credentials file not found ! "
      exit 1
fi


#Github API URL 
API_URL="https://api.github.com"

function Generate_SSH_Key_Pair(){
echo "Generatign SSH Key pair ......" 
ssh-keygen -t rsa -b 4096 -C "${email_address}" -f ~/.ssh/id_rsa_${Github_username} -N ""
echo " Successfully Generated Private key : id_rsa_${Github_username} Public key : id_rsa_${Github_username}.pub "
}

function Add_key_to_SSH_Agent(){
echo "Starting SSH agent in the background ..."
eval "$(ssh-agent -s)"
echo "Adding newly generated SSH key to the agent ..."
ssh-add ~/.ssh/id_rsa_${Github_username}
}

function Add_SSH_Public_key_To_Github()
{
url=${API_URL}/user/keys 
local Public_key=$(cat ~/.ssh/id_rsa_${Github_username}.pub)
# do a POST request 
# assuming you exported your username and PAT token
curl -s -u "${username1}:${token2}" -X POST \
     -H "Accept: application/vnd.github+json" \
     -d "{\"title\":\"${Github_username}_key\",\"key\":\"${Public_key}\"}" \
    "${url}"

}

function Setup_SSH_Config_file(){
echo -e "\nHost github-$ssh_alias\n    HostName github.com\n    User git\n    IdentityFile ~/.ssh/id_rsa_$Github_username" >> ~/.ssh/config
echo "SSH configuration for $ssh_alias added successfully!"
}

function Setup_git_Remote(){
current_dir=$(pwd)
if [ ${current_dir} == ${path} ]
then 
       echo "Already inside ${path} , proceeding ...."
       git remote add ${Github_username} git@github-${ssh_alias}:script-wizards-2025/Github-automation-scripts.git

else    
       echo "Not inside the correct path ,add it yourself  "
       exit 1 
fi
}

function Automate_SSH_Setup(){
Generate_SSH_Key_Pair
Add_key_to_SSH_Agent
Add_SSH_Public_key_To_Github
Setup_SSH_Config_file
Setup_git_Remote
echo "Testing SSH connection"
ssh -T git@github-${ssh_alias}
git remote -v 
}

# main script

# check required parameters 
if [ -z ${Github_username} ] || [ -z ${email_address} ] || [ -z ${ssh_alias} ] || [ -z ${path} ]
then 
     echo "Usage : $0 <github_username> <email_address> <ssh_alias> <path>"
     exit 1 
fi

Automate_SSH_Setup 