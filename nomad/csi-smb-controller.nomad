job "csi-smb-controller" {
  datacenters = ["dc1"]

  type = "service"

  namespace = "system"

  group "controller" {
    task "plugin" {
      driver = "docker"

      env {
        CSI_ENDPOINT = "unix:///csi/csi.sock"
      }

      config {
        image = "registry.k8s.io/sig-storage/smbplugin:v1.9.0"
        args = [
          "--v=5",
          "--endpoint=${CSI_ENDPOINT}"
        ]
      }

      csi_plugin {
        id        = "smb"
        type      = "controller"
        mount_dir = "/csi"
      }
    }
  }
}
