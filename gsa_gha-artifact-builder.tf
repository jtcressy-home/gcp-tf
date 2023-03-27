resource "google_service_account" "gha-artifact-builder" {
  project      = data.google_project.jtcressy-net.project_id
  account_id   = "gha-artifact-builder"
  display_name = "jtcressy-home/artifact-builder"
  description  = "Used to publish Artifact Registry artifacts from Github Actions"
}

## Service Account's Permissions

resource "google_project_iam_member" "gha-artifact-builder_artifact-writer" {
  project = data.google_project.jtcressy-net.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.gha-artifact-builder.email}"
}

## Service Account's Workload Identity Mapping

resource "google_service_account_iam_member" "gha-artifact-builder" {
  service_account_id = google_service_account.gha-artifact-builder.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${module.gh_oidc.pool_name}/attribute.repository_owner/jtcressy-home"
}

output "gsa-artifact-builder" {
  value = google_service_account.gha-artifact-builder.email
}