job "plex" {
  datacenters = ["dc1"]

  group "plex" {

    network {
        port "plex" {
        static = 32400
      }
    }

    task "plex" {
      driver = "docker"

      env {
        PUID=1000
        PGID=1000
        VERSION=docker
        # PLEX_CLAIM=
      }

      config {
        image = "lscr.io/linuxserver/plex:latest"

        ports = ["plex"]

        mount {
          type = "bind"
          source = "/mnt/storage/plex/movies"
          target = "/movies"
          readonly = "false"
        }  

        mount {
          type = "bind"
          source = "/mnt/storage/plex/tv"
          target = "/tv"
          readonly = "false"
        }  

        mount {
          type = "bind"
          source = "/mnt/storage/plex/library"
          target = "/config"
          readonly = "false"
        }  
      }
    }
  }
}
