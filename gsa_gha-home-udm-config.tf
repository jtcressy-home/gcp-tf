resource "google_service_account" "gha-home-udm-config" {
  project      = data.google_project.jtcressy-net.project_id
  account_id   = "gha-home-udm-config"
  display_name = "jtcressy-home/home-udm-config"
  description  = "Used by Github Actions to access terraform state"
}

## Service Account's Permissions

resource "google_project_iam_member" "gha-home-udm-config_storageAdmin" {
  project = data.google_project.jtcressy-net.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.gha-home-udm-config.email}"
}

## Service Account's Workload Identity Mappings

resource "google_service_account_iam_member" "gha-home-udm-config" {
  service_account_id = google_service_account.gha-home-udm-config.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${module.gh_oidc.pool_name}/attribute.sub/repo:jtcressy-home/home-udm-config:environment:terraform"
}