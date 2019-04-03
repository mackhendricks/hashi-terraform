variable "do_token" {}
variable "dropletname" {
    default="build-server"
}

variable "number_of_servers" {}


provider "digitalocean" {
        token = "${var.do_token}"
}



data "digitalocean_ssh_key" "jump" {
  name = "Jump"
}

resource "digitalocean_droplet" "dsiprouterDroplet" {
        name = "${var.dropletname}-${count.index}"
        count = "${var.number_of_servers}"
        region = "nyc1"
        size="1gb"
        image="debian-9-x64"
        ssh_keys = [ "${data.digitalocean_ssh_key.jump.fingerprint}" ]
        
}

output "ip" {
  value = "${digitalocean_droplet.dsiprouterDroplet.*.ipv4_address}"
}