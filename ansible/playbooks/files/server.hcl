data_dir  = "/var/lib/nomad"

datacenter = "dc1"

server {
  bootstrap_expect = 1
  enabled          = true

  # This is the IP address of the first server provisioned
  server_join {
    retry_join = ["pi0.local:4648"]
  }
}

client {
  enabled  = true
  cni_path = "/opt/cni/bin"

  /* host_volume "pihole-etc-pihole" { */
  /*   path = "/mnt/storage/pihole/pihole" */
  /*   read_only = false */
  /* } */
  /**/
  /* host_volume "pihole-etc-dnsmasq" { */
  /*   path = "/mnt/storage/pihole/dnsmasq" */
  /*   read_only = false */
  /* } */
}

plugin "docker" {
  config {
    allow_caps = [
      "audit_write", "chown", "dac_override", "fowner", "fsetid", "kill", "mknod",
      "net_bind_service", "setfcap", "setgid", "setpcap", "setuid", "sys_chroot",
      "net_raw", "sys_nice", "net_admin" # needed by pihole
    ]
    volumes {
      enabled = true
    }
  }
}
