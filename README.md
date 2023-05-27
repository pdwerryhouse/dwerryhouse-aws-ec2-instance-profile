# dwerryhouse-aws-ec2-instance-profile
Terraform module for creating an AWS ec2 instance profile

## Example of use

```bash
module "example1" {
  source = "../.."

  name = "example1"

  policy_attachments = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  ]

  policies = [
    {
      actions = ["kms:Decrypt"]
      resources = ["*"]
    }
  ]
}

output "arn" { value = module.example1.arn }
```
