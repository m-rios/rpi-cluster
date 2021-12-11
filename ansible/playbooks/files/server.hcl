data_dir  = "/var/lib/nomad"

datacenter = "dc1"

server {
  enabled          = true
  bootstrap_expect = 3

  # This is the IP address of the first server provisioned
  server_join {
    retry_join = ["pi0.local:4648"]
  }
  advertise {
    # Defaults to the first private IP address.
    http = "127.0.0.1"
    rpc  = "127.0.0.1"
    serf = "127.0.0.1"
  }
}

client {
  enabled = true
}
