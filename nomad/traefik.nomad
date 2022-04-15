job "traefik" {
  datacenters = ["dc1"]
  group "traefik" {
    network {
      port "http" {
        static = 80
      }
      port "ui" {
        static = 8080
      }
    }

    task "traefik" {
      driver = "docker"
      config {
        image = "traefik:v2.7"
      }
    }
  }
}
