## Sub-task 1

- AWS CLI is installed and configured with full access.

![](Attachments/aws-cli.png)

- S3 bucket as Terraform backend. Here is the terraform [config file. ](Terraform/state.tf)
## Sub-task 2

- This is the file structure of my terraform codebase.
- I have created modules for nat-gateway, security groups and vpc

```bash
➜  Terraform git:(main) ✗ tree                    
.
├── main.tf
├── modules
│   ├── nat-gateway
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── security-groups
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── vpc
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── state.tf
├── terraform.tfstate
├── terraform.tfstate.backup
├── terraform.tfvars
└── variables.tf

4 directories, 14 files
```

