resource "google_artifact_registry_repository" "unifi-os" {
  provider      = google-beta
  project       = data.google_project.jtcressy-net.project_id
  location      = "us"
  repository_id = "unifi-os"
  description   = "Custom Packages for Unifi OS >2.x"
  format        = "apt"
}