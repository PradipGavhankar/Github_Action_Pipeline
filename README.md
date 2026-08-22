# Github_Action_Pipeline, Dont do it in main brach, feature branch to be use for this run. for learning you can chooes to merge in main branch directly.
# 🚀 Terraform + GitHub Actions Complete CI/CD Pipeline

### Azure Resource Group Creation – Full Learning Project (Init → Plan → Apply)

---

## 🟢 पहले हिन्दी में आसान समझ

भाई, ये repository **Terraform + GitHub Actions** सीखने के लिए बनाई गई है।

इस project में हमने पूरा flow cover किया है:

1. Terraform से Azure Resource Group बनाना
2. GitHub Actions से automatic pipeline चलाना
3. Format Check → Init → Validate → Plan
4. Apply लोकल मशीन से करना (permission की वजह से)

ये वाला project तुम अपने दोस्तों और learning group में share कर सकते हो।  
**नाम से सब कुछ समझ में आएगा** (ID की जगह meaningful names use किए गए हैं)।

---

## 🔵 English Explanation

This repository is a complete hands-on learning project for **Terraform + GitHub Actions CI/CD**.

### What you will learn:
- How to write clean Terraform code
- How to create GitHub Actions pipeline
- How to run `terraform fmt`, `init`, `validate`, `plan`
- How to safely run `terraform apply`
- Best practices and common mistakes

This repo is designed as a **learning platform** so that anyone can understand and practice easily.

---

## 🧱 Project Structure

```bash
Github_Action_Pipeline/
│
├── .github/
│   └── workflows/
│       └── terraform.yml          # GitHub Actions pipeline
│
├── .gitignore                     # Important files ignore करने के लिए
├── .terraform.lock.hcl            # Provider version lock
│
├── main.tf                        # Resource Group code
├── provider.tf                    # Azure provider configuration
├── variables.tf                   # Input variables
├── output.tf                      # Output values
│
└── README.md                      # This file
```
![Terraform Workflow for Github Action](../Snaps/Code_Github_Action_infra_creation_using_Terraform_command_automation.png)

## 🧱 Terraform Code (Simple + Hindi Comments)
### 1. provider.tf
```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"          # Version lock – बहुत जरूरी है
    }
  }
}

provider "azurerm" {
  features {}
}
```
### 2. variables.tf
```hcl
variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
  default     = "rg-terraform-learning"
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "East US"
}
```
### 3. main.tf
Azure Resource Group बनाना
```
resource "azurerm_resource_group" "learning_rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = "Learning"
    CreatedBy   = "Terraform"
    Project     = "GitHub-Actions-Pipeline"
  }
}
```

### 4. output.tf
```hcl
output "resource_group_name" {
  description = "Name of the created Resource Group"
  value       = azurerm_resource_group.learning_rg.name
}

output "resource_group_location" {
  description = "Location of the Resource Group"
  value       = azurerm_resource_group.learning_rg.location
}
```
## 🛠️ GitHub Actions Pipeline
folder structure to keep File: .github/workflows/terraform.yml
```
name: Terraform CI/CD - Full Pipeline

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  terraform:
    name: Terraform Full Pipeline
    runs-on: ubuntu-latest

    # Azure credentials (baad me real values daalna)
    env:
      ARM_CLIENT_ID: ${{ secrets.ARM_CLIENT_ID }}
      ARM_CLIENT_SECRET: ${{ secrets.ARM_CLIENT_SECRET }}
      ARM_SUBSCRIPTION_ID: ${{ secrets.ARM_SUBSCRIPTION_ID }}
      ARM_TENANT_ID: ${{ secrets.ARM_TENANT_ID }}

    steps:
      - name: 1. Checkout Repository
        uses: actions/checkout@v4

      - name: 2. Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.9.0

      - name: 3. Terraform Format Check
        run: terraform fmt -check

      - name: 4. Terraform Init
        run: terraform init

      - name: 5. Terraform Validate
        run: terraform validate

      - name: 6. Terraform Plan
        run: terraform plan -no-color -input=false
        continue-on-error: true

      # Apply only on main branch push
      - name: 7. Terraform Apply
        if: github.ref == 'refs/heads/main' && github.event_name == 'push'
        run: terraform apply -auto-approve -input=false
        
```
### 🚀 How to Run Complete Project (Step-by-Step)
Step 1: Clone the Repository
Bashgit clone https://github.com/PradipGavhankar/Github_Action_Pipeline.git
cd Github_Action_Pipeline
Step 2: Login to Azure
Bashaz login
Step 3: Initialize Terraform
Bashterraform init
Step 4: Check Formatting
Bashterraform fmt -check
Step 5: Validate Configuration
Bashterraform validate
Step 6: See the Plan
Bashterraform plan
Step 7: Apply (Create Resource Group)
Bashterraform apply
Type yes when asked.

![Terraform Workflow for Github Action](../Snaps/Github_Action_infra_creation_using_Terraform_command_automation.png)

### 🚀 Real Output Example
BashTerraform will perform the following actions:
```
  # azurerm_resource_group.learning_rg will be created
  + resource "azurerm_resource_group" "learning_rg" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "rg-terraform-learning"
      + tags     = {
          + "CreatedBy"   = "Terraform"
          + "Environment" = "Learning"
          + "Project"     = "GitHub-Actions-Pipeline"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
After successful apply you will see:
BashApply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
Outputs:
```
resource_group_name = "rg-terraform-learning"
resource_group_location = "eastus"
```
### ✅ Good Practice (Production Ready Mindset)
✔ Always use version constraint (~> 5.0)
✔ Variables use करो – hardcoding मत करो
✔ State file को Git में commit मत करो
✔ terraform plan production में mandatory है
✔ Meaningful names use करो (ID की जगह)
✔ Tags जरूर लगाओ
✔ .gitignore properly maintain करो
✔ Format check pipeline में रखो

### ❌ Bad Practice (Danger Zone)
❌ Hardcoded values (subscription, names, etc.)
❌ State file GitHub में push करना
❌ बिना plan के direct apply करना
❌ Portal से manually change करना
❌ .terraform/ folder commit करना
❌ Version lock न लगाना

### 😂 Thoda DevOps Comedy
"Portal से Resource Group बनाना = 2 minute का काम
Terraform से बनाना = 2 दिन का learning + lifetime का confidence"
"GitHub Actions में Plan fail होना डराता है...
लेकिन जब Local में Apply successful होता है तो मजा ही आ जाता है 😎"

### 🎯 Interview Closing Line
"I created a complete Terraform project integrated with GitHub Actions. The pipeline automatically performs formatting, initialization, validation and planning. Apply is executed manually for safety. I also learned proper use of .gitignore, version locking, meaningful naming and avoiding common mistakes like committing state files or provider binaries."

## 📌 Author

**Pradip Gavhankar**  
*DevOps | Cloud | DevSecOps | FinOps Learning Journey*
