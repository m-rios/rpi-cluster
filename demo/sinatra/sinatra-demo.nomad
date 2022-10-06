job "sinatra-demo" {
  datacenters = ["dc1"]

  group "sinatra-demo" {
    count = 1

    network {
      port  "http" {
        to = 4567
      }
    }

    service {
      name = "demo-webapp"
      port = "http"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.http.rule=Host(`sinatra.pi.cluster`)"
      ]

      check {
        type     = "http"
        path     = "/ping"
        interval = "5s"
        timeout  = "2s"
      }
    }

    task "web" {
      driver = "docker"

      config {
        image = "mariorios/sinatra-demo"
        force_pull = true
        ports = ["http"]
      }
    }
  }
}


