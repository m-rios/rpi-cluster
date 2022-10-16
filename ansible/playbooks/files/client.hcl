data_dir  = "/var/lib/nomad"

datacenter = "dc1"

bind_addr = "{{ GetInterfaceIP \"eth0\" }}"

client {
  enabled = true
  server_join {
    retry_join = ["pi0.cluster"]
  }
}

plugin "docker" {
  config {
    allow_caps = [
      "audit_write", "chown", "dac_override", "fowner", "fsetid", "kill", "mknod",
      "net_bind_service", "setfcap", "setgid", "setpcap", "setuid", "sys_chroot",
      "net_raw", "sys_nice", "net_admin" # needed by pihole
    ]
    allow_privileged = true
    volumes {
      enabled = true
    }
  }
}
