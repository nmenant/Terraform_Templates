provider "bigip" {
  address     = var.f5_public_ip
  port        = var.f5_mgmt_port
  username    = var.f5_admin_user
  password    = var.f5_admin_password
}

resource "bigip_as3"  "as3-declaration" {
  as3_json    = "${file(var.as3_filename)}"
 }
