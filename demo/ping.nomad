job "ping" {
  datacenters = ["dc1"]
  group "ping" {

    network {
      port "http" {}
    }

    service {
      name = "ping"
      port = "http"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.ping.rule=Host(`ping.pi.cluster`)"
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "5s"
        timeout  = "2s"
      }
    }

    task "ping" {
      driver = "exec"
      
      config {
        command = "ping_server"
        args = ["--addr", ":${NOMAD_PORT_http}"]
      }

      artifact {
        source = "https://github.com/m-rios/learning-go/releases/download/v0.0.0/ping_armv7l"
        destination = "/usr/local/bin/ping_server"
        mode = "file"
      }
    }
  }
}
