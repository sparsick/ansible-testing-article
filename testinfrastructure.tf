variable "hcloud_token" {}
variable "ssh_key" {}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = var.hcloud_token
}

# Create a server
resource "hcloud_server" "ansible-tests" {
  name = "ansible-tests"
  image = "ubuntu-18.04"
  server_type = "cx11"
  location = "nbg1"
  ssh_keys = [
    "ansible-test-infrastructure"
  ]

  provisioner "remote-exec" {
   inline = [
     "while fuser /var/lib/apt/lists/lock >/dev/null 2>&1; do sleep 1; done",
     "apt-get -qq update -y",
     "apt-get -qq install python -y",
   ]
   connection {
     type        = "ssh"
     user        = "root"
     private_key = file(var.ssh_key)
     host = hcloud_server.ansible-tests.ipv4_address
   }
  }
}

output "public_ip_address" {
  value = "${hcloud_server.ansible-tests.ipv4_address}"
}
