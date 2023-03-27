module "project-services" {
  source  = "registry.terraform.io/terraform-google-modules/project-factory/google//modules/project_services"
  version = "v13.0.0"

  project_id = data.google_project.jtcressy-net.project_id

  activate_apis = [
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com",
    "artifactregistry.googleapis.com",
  ]
}