# GitHub Automation Scripts 🚀  

This repository contains Bash scripts to automate various GitHub tasks using the **GitHub APIs**. These scripts help with repository management, collaborators, and other automation workflows.  

---

## 🛠 Setup  

### 1️⃣ Clone the Repository  
```bash
git clone https://github.com/script-wizards-2025/github-automation-scripts.git
cd github-automation-scripts
```
### 2️⃣ Install Dependencies
```bash 
sudo apt install jq -y 
```
### 3️⃣ Set Up Authentication
Since config/credentials.env is ignored via .gitignore, you need to manually create it for you . 

- Create a credentials file - 
```bash
mkdir -p config
touch config/credentials.env
```
- Open config/credentials.env and add your GitHub username and token - 
```bash
username="your_username"
token="your_personal_access_token"
```
⚠️ Do NOT commit this file to GitHub, as it contains sensitive information.

## 📜 Available Scripts

### Add-Remove-collabs.sh
Description:This script allows you to add or remove collaborators from a specified GitHub repository. You can grant specific permissions when adding a collaborator and remove collaborators as needed.
 - To **add** a collaborator with a specific permission (read/write/admin/maintain/Triage):
```bash
./Add-Remove-collabs.sh <Org_name> <Repo_name> <Collaborator> add <Permission>
```
 - To **remove** a collaborator
```bash
./Add-Remove-collabs.sh <Org_name> <Repo_name> <Collaborator> remove
```
### list-read-collaborators.sh 
Description: Retrieves and lists all collaborators with read access from the specified GitHub repository.
```bash
./list-read-collaborators.sh <Org_name> <Repo_name>
```
### setup-github-ssh.sh
Description: Automates GitHub SSH key setup for multiple accounts. The script handles key generation, GitHub configuration, and remote setup.

Usage:
```bash
./setup-github-ssh.sh <github_username> <email_address> <ssh_alias> <path>
```
### switch-gituser.sh
Description: Seamlessly switch between multiple GitHub accounts using SSH configurations. Perfect for managing different GitHub identities (personal, work, organization accounts).

Usage:
```bash
./switch-gituser.sh <alias>
```

## 📂 Project Structure 
```
github-automation-scripts/
│── scripts
│   ├── Add-Remove-collabs.sh
│   ├── list-read-collabs.sh
│   ├── setup-github-ssh.sh
│   └── switch-gituser.sh
│── config/  
│   ├── credentials.env(GitHub authentication)   
│   ├── github_accounts.conf (Account configurations )               
│── .gitignore                   
│── README.md                
```
### Config File Structure
credentials.env should contain your GitHub credentials:
```bash
username1="first_github_account"
token1="first_account_pat_token"
username2="second_github_account"
token2="second_account_pat_token"
```
### Github_accounts.conf - Account configurations:
```conf
# Format: alias username email

# Work1 accounts
project1 project-maintainer maintainer@project.org
testing test-automation testing@project.org

# Work2 accounts
work dev-team-lead lead@company.com
staging staging-deploy deploy@company.com

```
⚠️ All config files are git-ignored for security. Create them locally following these templates.

## ⭐ Support

If you found this useful, feel free to star this repository!





