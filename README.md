# ansible-testing-article
Demo code for my article about testing ansible playbooks

tested with
ansible-lint

Terraform v0.12.16
+ provider.hcloud v1.15.0


ansible
+ hcloud-python (pip install hcloud )

## Run ansible-lint


## Setup Test infrastructure

terraform init

terraform apply -var="hcloud_token=..."

terraform destroy -var="hcloud_token=..."



## Run Ansible
ansible-playbook -u root --private-key=/home/sparsick/.ssh/id_hetzner_ansible_test -i inventory/test.hcloud.yml setup-tomcat.yml
