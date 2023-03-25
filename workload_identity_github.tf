module "gh_oidc" {
  source            = "registry.terraform.io/terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version           = "3.0.0"
  pool_description  = "Github Actions workload identity pool"
  pool_display_name = "github-actions"

  project_id  = data.google_project.jtcressy-net.project_id
  pool_id     = "github-actions"
  provider_id = "github-actions"

  attribute_mapping = {
    "google.subject" : "assertion.sub",
    "attribute.sub" : "assertion.sub",
    "attribute.repository" : "assertion.repository",
    "attribute.aud" : "assertion.aud",
    "attribute.actor" : "assertion.actor",
    "attribute.repository" : "assertion.repository",
    "attribute.repository_owner" : "assertion.repository_owner",
    "attribute.job_workflow_ref" : "assertion.job_workflow_ref",
    "attribute.environment" : "assertion.environment"
  }

  sa_mapping = {
    "github-jtcressy-net-gcp-tf" = {
      sa_name   = google_service_account.gha-gcp-tf.name
      attribute = "attribute.sub/repo:jtcressy-home/gcp-tf:ref:refs/heads/main"
    }
  }
}

output "workload_identity_provider_name" {
  value = module.gh_oidc.provider_name
}