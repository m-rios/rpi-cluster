job "traefik" {
  region      = "global"
  datacenters = ["dc1"]
  type        = "service"

  namespace = "system"

  affinity {
    attribute = "${attr.unique.hostname}"
    operator = "="
    value = "pi0"
  }

  group "traefik" {
    count = 1

    network {
      port "http" {
        static = 80
      }

      port "api" {
        static = 8081
      }
    }

    service {
      name = "traefik"

      check {
        name     = "alive"
        type     = "tcp"
        port     = "http"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "traefik" {
      driver = "docker"

      config {
        image        = "traefik:v2.2"
        network_mode = "host"

        volumes = [
          "local/traefik.toml:/etc/traefik/traefik.toml",
        ]
      }

      template {
        data = <<EOF
[entryPoints]
    [entryPoints.http]
    address = ":80"
    [entryPoints.traefik]
    address = ":8081"

[api]
    dashboard = true
    insecure  = true

[providers]
  [providers.file]
    filename = "local/dynamic.toml"

# Enable Consul Catalog configuration backend.
[providers.consulCatalog]
    prefix           = "traefik"
    exposedByDefault = false

    [providers.consulCatalog.endpoint]
      address = "127.0.0.1:8500"
      scheme  = "http"
EOF

        destination = "local/traefik.toml"
      }

      template {
        data = <<EOF
[http.routers]
  [http.routers.nomad]
    rule = "Host(`nomad.pi.cluster`)"
    service = "nomad"

[http.services]
  [http.services.nomad.loadBalancer]
    [[http.services.nomad.loadBalancer.servers]]
      url = "http://192.168.1.136:4646/"

EOF

        destination = "local/dynamic.toml"
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }
  }
}

