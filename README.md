# ansible-testing-article
Demo code for my article "Automated Quality Assurance for Ansible Playbooks".
It's about automated testing for ansible playbooks.

The code samples are tested with:
* Hetzner Cloud
* ansible-lint 4.1.0
* Terraform v0.12.16 with provider plugin hcloud v1.15.0
* Ansible 2.9.1 with inventory plugin hcloud-python (pip install hcloud )
* testinfra 3.2.0

Note: You have to configure a API Token and a SSH key in your Hetzner Cloud.

## Run ansible-lint
```
ansible-lint setup-tomcat.yml
```

## Setup Test infrastructure
```
terraform init
terraform apply -var="hcloud_token=..."
terraform destroy -var="hcloud_token=..."
```
API Token is needed by terraform.
You set the token via variable `hcloud_token`


## Run Ansible
```
export HCLOUD_TOKEN="..."
ansible-playbook --private-key=/home/sparsick/.ssh/id_hetzner_ansible_test -i inventory/test.hcloud.yml setup-tomcat.yml
```
Ansible needs also a configured API Token via system environment `HCLOUD_TOKEN`.

## Run Python Tests
Need the Ansible configuration in ansible.cfg

```
py.test --connection=ansible --ansible-inventory=inventory/test.hcloud.yml --force-ansible -v tests/*.py
```
