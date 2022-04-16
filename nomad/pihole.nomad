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

    task "pihole" {
      driver = "docker"

      config {
        image        = "pihole/pihole:2022.04.2"
        network_mode = "bridge"
        ports        = ["http", "dns"]
      }
    }
  }
}

