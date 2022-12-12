job "minecraft" {
  datacenters = ["dc1"]

  group "minecraft" {
    network {
      # game port
      port "mc" {
        static = 25565
      }
      # recon
      port "rc" {
        static = 25575
      }
    }

    task "server" {
      driver = "java"

      artifact {
        source = "https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar"  
      }

      config {
        args = ["--nogui"]
        jar_path = "/local/server.jar"
        jvm_options = ["-Xmx5048m", "-Xms5048m"]
      }

      resources {
        cpu    = 500
        memory = 2048
      }

      template {
        data = <<EOF
eula=true
EOF

        destination = "eula.txt"
      }
      template {
        data = <<EOF
#Minecraft server properties
#Tue Jan 25 04:59:58 UTC 2022
enable-jmx-monitoring=false
rcon.port=25575
level-seed=
gamemode=survival
enable-command-block=true
enable-query=false
generator-settings=
level-name=world
motd=Minecraft server running from nomad.
query.port=25565
pvp=true
generate-structures=true
difficulty=hard
network-compression-threshold=256
max-tick-time=60000
require-resource-pack=false
max-players=10
use-native-transport=true
online-mode=false
enable-status=true
allow-flight=false
broadcast-rcon-to-ops=true
view-distance=10
max-build-height=256
resource-pack-prompt=
server-ip=
allow-nether=true
server-port=25565
sync-chunk-writes=true
enable-rcon=false
op-permission-level=4
prevent-proxy-connections=false
hide-online-players=false
resource-pack=
entity-broadcast-range-percentage=100
simulation-distance=10
rcon.password=
player-idle-timeout=0
force-gamemode=false
rate-limit=0
hardcore=false
white-list=true
broadcast-console-to-ops=true
spawn-npcs=true
spawn-animals=true
snooper-enabled=true
function-permission-level=2
level-type=default
text-filtering-config=
spawn-monsters=true
enforce-whitelist=true
spawn-protection=16
resource-pack-sha1=
max-world-size=29999984
EOF
        destination = "server.properties"
      }
    }
  }
}
