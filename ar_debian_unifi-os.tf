resource "google_artifact_registry_repository" "unifi-os" {
  provider      = google-beta
  project       = data.google_project.jtcressy-net.project_id
  location      = "us"
  repository_id = "unifi-os"
  description   = "Custom Packages for Unifi OS >2.x"
  format        = "apt"
}

resource "google_artifact_registry_repository_iam_member" "unifi-os_public" {
  provider   = google-beta
  project    = data.google_project.jtcressy-net.project_id
  location   = google_artifact_registry_repository.unifi-os.location
  repository = google_artifact_registry_repository.unifi-os.name
  role       = "roles/artifactregistry.reader"
  member     = "allUsers"
}