data "google_project" "jtcressy-net" {
  project_id = "jtcressy-net-235001"
}

data "google_organization" "jtcressy-net" {
  domain = "jtcressy.net"
}

data "google_billing_account" "jtcressy-net" {
  display_name = "jtcressy-net"
  open         = true
}