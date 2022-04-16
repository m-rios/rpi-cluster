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

  host_volume "pihole-etc-pihole" {
    path = "/mnt/storage/pihole/pihole"
    read_only = false
  }

  host_volume "pihole-etc-dnsmasq" {
    path = "/mnt/storage/pihole/dnsmasq"
    read_only = false
  }

  # host_volume "storage" {
  #   path = "/mnt/storage"
  #   read_only = false
  # }
}
