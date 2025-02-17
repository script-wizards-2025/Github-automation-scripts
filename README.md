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
## 📂 Project Structure 
```
github-automation-scripts/
│── scripts
│   ├── Add-Remove-collabs.sh
│   ├── list-read-collabs.sh
│── config/                      
│── .gitignore                   
│── README.md                
```
## ⭐ Support

If you found this useful, feel free to star this repository!





