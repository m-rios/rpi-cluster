job "csi-smb-nodes" {
  datacenters = ["dc1"]

  type = "system"

  namespace = "system"

  group "nodes" {
    task "plugin" {
      driver = "docker"

      env {
        CSI_ENDPOINT = "unix:///csi/csi.sock"
      }

      config {
        image = "registry.k8s.io/sig-storage/smbplugin:v1.9.0"
        args = [
          "--v=5",
          "--endpoint=${CSI_ENDPOINT}",
          "--nodeid=${attr.unique.hostname}"
        ]
        privileged = true
      }

      csi_plugin {
        id        = "smb"
        type      = "node"
        mount_dir = "/csi"
      }
    }
  }
}
