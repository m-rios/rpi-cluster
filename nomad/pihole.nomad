job "pihole" {
  region      = "global"
  datacenters = ["dc1"]
  type        = "service"

  group "pihole" {
    count = 1

    network {
      mode = "bridge"

      port "http" {
        to     = 80
      }

      port "dns" {
        static = 53
        to     = 53
      }
    }

    service {
      name = "pihole"

      check {
        name     = "alive"
        type     = "tcp"
        port     = "http"
        interval = "10s"
        timeout  = "2s"
      }
    }

    volume "pihole-etc-pihole" {
      type      = "host"
      source    = "pihole-etc-pihole"
      read_only = false
    }

    volume "pihole-etc-dnsmasq" {
      type      = "host"
      source    = "pihole-etc-dnsmasq"
      read_only = false
    }

    task "pihole" {
      driver = "docker"

      env {
        DNSMASQ_USER = "root"
        DNSSEC = "true"
        TZ = "Europe/Madrid"
      }

      config {
        image        = "pihole/pihole:2022.04.2"
        network_mode = "bridge"
        ports        = ["http", "dns"]
        cap_add      = ["net_admin"]
      }

      volume_mount {
        volume      = "pihole-etc-pihole"
        destination = "/etc/pihole"
      }

      volume_mount {
        volume      = "pihole-etc-dnsmasq"
        destination = "/etc/dnsmasq"
      }
    }
  }
}

