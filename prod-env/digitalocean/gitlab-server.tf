variable "gitlab_hostname" {
    default="gitlab"
}

variable "gitlab_number_of_servers" {
    default="1"
}


resource "digitalocean_droplet" "gitlab_server" {
        name = "${var.gitlab_hostname}-${count.index}"
        count = "${var.gitlab_number_of_servers}"
        region = "nyc1"
        size="1gb"
        image="debian-9-x64"
        ssh_keys = [ "${data.digitalocean_ssh_key.jump.fingerprint}" ]
        
}

output "gitlab_ip" {
  value = "${digitalocean_droplet.gitlab_server.*.ipv4_address}"
}
