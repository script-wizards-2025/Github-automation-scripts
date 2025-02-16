#!/bin/bash

###########################################################################################################
# Author - Ritik Gupta
# Date   - 15 feb 2025 
# version- v1
#
# Description - This script retrieves and lists all collaborators from the specified repository and organization 
# that I have access to.
############################################################################################################
if[ -f "config/credentials.env" ] 
then 
      source config/credentials.env
else    
      echo " Error: config/credentials file not found ! "
      exit 1
fi

#Github API URL 
API_URL="https://api.github.com"

# User and Repository information 
Owner_name=$1
Repo_name=$2

function Get_Collaborators(){
local url="${API_URL}/repos/${Owner_name}/${Repo_name}/collaborators"
# send a get request to github api with authentication 
curl -s -u "${Username}:${Token}" "${url}"
}

function list_collaborators_with_Read_Access(){
  # fetch all coloborators 
  collaborators="$(Get_Collaborators |jq -r '.[] | select(.role_name == "read") | .login')"
  # Display the colobarators with read access 
  if [ -z "${collaborators}" ]
  then 
        echo "no users with read access "
  else      
        echo "${collaborators}"
  fi 

}

# main script 
if [ $# -ne 2 ]
then 
    echo " Usage : $0 <Owner_name> <Repo_name> "
    echo " please put the args as avobe usage example " 
else 
    echo " listing users with read access to ${Owner_name}/${Repo_name}"
    list_collaborators_with_Read_Access
fi










