job "sinatra-demo" {
  datacenters = ["dc1"]

  group "sinatra-demo" {
    count = 3

    network {
      port  "http" {
        to = 4567
      }
    }

    update {
      max_parallel     = 1
      canary           = 1
      min_healthy_time = "5s"
      healthy_deadline = "2m"
      progress_deadline = 0 # cause first unhealthy allocation to fail the deployment
      auto_revert      = true
      auto_promote     = false
    }

    service {
      name = "demo-webapp"
      port = "http"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.sinatra-demo.rule=Host(`sinatra.pi.cluster`)"
      ]

      canary_tags = [
        "traefik.enable=false"
      ]

      check {
        type     = "http"
        path     = "/ping"
        interval = "5s"
        timeout  = "2s"
      }
    }

    service {
      name = "demo-webapp-canary"
      port = "http"
      tags = []
      canary_tags = [
        "traefik.enable=true",
        /* "traefik.frontend.rule=Host:api.localhost;Headers: Canary,true" */
        "traefik.http.routers.sinatra-demo-canary.rule=Host(`canary.sinatra.pi.cluster`)"
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
        image = "mariorios/sinatra-demo:latest"
        ports = ["http"]
      }
    }
  }
}


