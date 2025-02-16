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
GITHUB_USERNAME="your_username"
GITHUB_TOKEN="your_personal_access_token"
```
⚠️ Do NOT commit this file to GitHub, as it contains sensitive information.

## 📜 Available Scripts

### list-read-collaborators.sh 
Description: Retrieves and lists all collaborators with read access from the specified GitHub repository.
```bash
./scripts/list-read-collaborators.sh <Owner_name> <Repo_name>
```
## 📂 Project Structure 
```
github-automation-scripts/
│── scripts
│   ├── list-read-collaborators.sh
│── config/                      
│── .gitignore                   
│── README.md                
```
## ⭐ Support

If you found this useful, feel free to star this repository!





