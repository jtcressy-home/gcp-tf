resource "google_service_account" "gha-packer-builder" {
  project      = data.google_project.jtcressy-net.project_id
  account_id   = "gha-packer-builder"
  display_name = "jtcressy-home/packer-builder"
  description  = "Used to build VM Images using Packer from Github Actions"
}

## Service Account's Permissions

resource "google_project_iam_member" "gha-packer-builder_computeInstanceAdmin" {
  project = data.google_project.jtcressy-net.project_id
  role    = "roles/compute.instanceAdmin"
  member  = "serviceAccount:${google_service_account.gha-packer-builder.email}"
}

resource "google_service_account_iam_member" "gha-packer-builder_computeDefault" {
  service_account_id = data.google_compute_default_service_account.jtcressy-net.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.gha-packer-builder.email}"
}

## Service Account's Workload Identity Mapping

resource "google_service_account_iam_member" "gha-packer-builder" {
  service_account_id = google_service_account.gha-packer-builder.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${module.gh_oidc.pool_name}/attribute.repository_owner/jtcressy-home"
}

output "gsa-packer-builder" {
  value = google_service_account.gha-packer-builder.email
}
