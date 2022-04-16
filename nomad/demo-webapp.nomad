job "demo-webapp" {
  datacenters = ["dc1"]

  group "demo" {
    count = 1

    network {
      port  "http"{
        to = 80
      }
    }

    service {
      name = "demo-webapp"
      port = "http"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.http.rule=Path(`/`)",
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
          "local/index.html:/usr/share/nginx/html/index.html",
        ]
      }

      template {
        data = <<EOF
          <!DOCTYPE html>
          <html>
                  <body>
                          OK
                  </body>
          </html>
        EOF
        destination = "local/index.html"
      }
    }
  }
}


