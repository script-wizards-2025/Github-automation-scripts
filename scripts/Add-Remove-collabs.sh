#!/bin/bash
###########################################################################################################
# Author - Ritik Gupta
# Date   - 17 feb 2025 
# version- v1
#
# Description - This scripts 
############################################################################################################

if [ -f "../config/credentials.env" ] 
then 
      source ../config/credentials.env
else    
      echo " Error: config/credentials file not found ! "
      exit 1
fi

#Github API URL 
API_URL="https://api.github.com"

# User and Repository information 
Org_name=$1
Repo_name=$2
Collaborator=$3
Action=$4 # "add" / "remove"
Permissions=$5 # Needs to be passed for "add" action only 
# read / write / admin / maintain

url="${API_URL}/repos/${Org_name}/${Repo_name}/collaborators/${Collaborator}"

function Add_Collaborators(){
# do a put request 
curl -s -u "${username}:${token}" -X PUT \
     -H "Accept: application/vnd.github.v3+json" \
     -d "{\"permission\":\"${Permissions}\"}" \
     "${url}"
}

function Get_Collaborators(){
local url="${API_URL}/repos/${Org_name}/${Repo_name}/collaborators"
# do a get request for getting all collaborators 
curl -s -u "${username}:${token}" "${url}"
}

function Owner_collaborators(){
 
 local url="${API_URL}/orgs/${Org_name}/members?role=owner"
 # do a get request for getting owners 
 curl -s -u "${username}:${token}" "${url}"

}

function Remove_Collaborators(){

All_collaborators="$(Get_Collaborators | jq -r '.[] |.login')"

All_org_owners="$(Owner_collaborators | jq -r '.[] |.login')"

# Convert the owners into a regex for grep, join them with '|'
Owner_regex=$(echo "${All_org_owners}" | tr '\n' '|' | sed 's/|$//')

# Filter out the owners from the collaborators list
filtered_collaborators=$(echo "${All_collaborators}" | grep -v -E "^(${Owner_regex})$")

if [ -z "${filtered_collaborators}" ]
then 
      echo "no collaborators to remove , only owner of the org present"
      exit 1 
fi 

if echo "${filtered_collaborators}" | grep -wq "${Collaborator}" 

then 
      # do a delete request 
      curl -s -u "${username}:${token}" -X DELETE \
      -H "Accept: application/vnd.github.v3+json" \
      "${url}"
      
else 
      echo "Collaborator does not exist so will not be able to remove !"

fi    

}

# main script 

if [ $# -lt 4 ] 
then 
   echo " Usage:"
   echo " To add collaborator : $0 <Org_name> <Repo_name> <Collaborator> add <Permission> "
   echo " To remove collaborator : $0 <Org_name> <Repo_name> <Collaborator> remove "
   exit 1 
fi 

case $Action in 

      add)
            if [ $# -ne 5 ]
            then 
                  echo " Error : Permission arg missing " 
            else 
                  echo "Attempting to add ${Collaborator} to ${Org_name}/${Repo_name} with ${Permissions} access..."
                  Add_Collaborators
            fi 
            ;;

      remove)

            if [ $# -ne 4 ] 
            then 
                  echo " Error : Extra args provided " 
                  exit 1 
            else 
                  echo "Attempting to remove ${Collaborator} from ${Org_name}/${Repo_name}..."
                  Remove_Collaborators
            fi
            ;;
      *)
            echo " Invalid action . Use 'add' or 'remove' " 
            exit 1 
            ;;
esac 
