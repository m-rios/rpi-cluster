job "sinatra-demo" {
  datacenters = ["dc1"]

  group "sinatra-demo" {
    count = 1

    network {
      port  "http" {}
    }

    service {
      name = "demo-webapp"
      port = "http"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.http.rule=Path(`/sinatra`)",
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
        ports = ["http"]
      }
    }
  }
}


