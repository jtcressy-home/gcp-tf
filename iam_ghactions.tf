resource "google_service_account" "gha-gcp-tf" {
  account_id   = "gha-gcp-tf"
  display_name = "jtcressy-net/gcp-tf/main"
}

resource "google_project_iam_member" "github-jtcressy-net-gcp-tf_owner" {
  project = data.google_project.jtcressy-net.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.gha-gcp-tf.email}"
}

resource "google_organization_iam_member" "github-jtcressy-net-gcp-tf_orgAdmin" {
  org_id = data.google_organization.jtcressy-net.org_id
  role   = "roles/resourcemanager.organizationAdmin"
  member = "serviceAccount:${google_service_account.gha-gcp-tf.email}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_organization_iam_member" "github-jtcressy-net-gcp-tf_billingAdmin" {
  org_id = data.google_organization.jtcressy-net.org_id
  role   = "roles/billing.admin"
  member = "serviceAccount:${google_service_account.gha-gcp-tf.email}"

  lifecycle {
    create_before_destroy = true
  }
}