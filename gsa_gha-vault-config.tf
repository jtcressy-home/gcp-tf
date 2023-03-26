resource "google_service_account" "gha-vault-config" {
  project      = data.google_project.jtcressy-net.project_id
  account_id   = "gha-vault-config"
  display_name = "jtcressy-home/vault-config"
  description  = "Used by Github Actions to access terraform state"
}

## Service Account's Permissions

resource "google_project_iam_member" "gha-vault-config_owner" {
  project = data.google_project.jtcressy-net.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.gha-vault-config.email}"
}

resource "google_project_iam_member" "gha-vault-config_storageAdmin" {
  project = data.google_project.jtcressy-net.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.gha-vault-config.email}"
}

## Service Account's Workload Identity Mappings

resource "google_service_account_iam_member" "gha-vault-config_vault-config" {
  service_account_id = google_service_account.gha-vault-config.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${module.gh_oidc.pool_name}/attribute.sub/repo:jtcressy-home/vault-config:environment:vault-config"
}

resource "google_service_account_iam_member" "gha-vault-config_vault-deploy" {
  service_account_id = google_service_account.gha-vault-config.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${module.gh_oidc.pool_name}/attribute.sub/repo:jtcressy-home/vault-config:environment:vault-deploy"
}