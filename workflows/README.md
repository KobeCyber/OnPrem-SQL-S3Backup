##  Setting Up AWS Credentials for GitHub Actions

Before you run this Terraform workflow, you need to provide AWS credentials so Terraform can authenticate with your AWS account.

In **GitHub Actions**, this is done by creating two **repository secrets**.

### Required Secrets

| Secret Name              | Description                        |
|--------------------------|------------------------------------|
| `AWS_ACCESS_KEY_ID`      | Your AWS access key ID             |
| `AWS_SECRET_ACCESS_KEY`  | Your AWS secret access key         |

These secrets allow Terraform to authenticate and deploy the resources defined in the `main.tf` file.
