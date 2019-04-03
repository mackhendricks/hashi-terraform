


provider "digitalocean" {
        token = "${var.do_token}"
}



data "digitalocean_ssh_key" "jump" {
  name = "Jump"
}

resource "digitalocean_droplet" "build-server" {
        name = "${var.dropletname}-${count.index}"
        count = "${var.number_of_servers}"
        region = "nyc1"
        size="1gb"
        image="debian-9-x64"
        ssh_keys = [ "${data.digitalocean_ssh_key.jump.fingerprint}" ]
        
}

output "ip" {
  value = "${digitalocean_droplet.build-server.*.ipv4_address}"
}