# ansible-testing-article
Demo code for my article about testing ansible playbooks

tested with
Terraform v0.12.16
+ provider.hcloud v1.15.0


## Setup Test infrastructure

terraform init

terraform apply -var="hcloud_token=..."

terraform destroy -var="hcloud_token=..."
