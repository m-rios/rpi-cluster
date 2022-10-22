type        = "csi"
id          = "smb"
name        = "smb"
external_id = "${aws_ebs_volume.mysql.id}"
plugin_id   = "smb"

capability {
  access_mode     = "single-node-writer"
  attachment_mode = "file-system"
}
