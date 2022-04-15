job "demo-webapp" {
  datacenters = ["dc1"]

  group "demo" {
    count = 3

    network {
      port  "http"{
        to = -1
      }
    }

    service {
      name = "demo-webapp"
      port = "http"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.http.rule=Path(`/myapp`)",
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "2s"
        timeout  = "2s"
      }
    }

    task "server" {
      driver = "docker"

      config {
        image = "nginx:1.20.2"
        ports = ["http"]
        volumes = [
          "./files:/usr/share/nginx/html:ro"
        ]
      }
    }
  }
}


