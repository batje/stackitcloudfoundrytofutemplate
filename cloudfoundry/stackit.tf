data "stackit_resourcemanager_project" "cloudfoundry_project" {
  project_id = var.project_id
}


data "stackit_scf_organization" "scf_org" {
  org_id     = var.org_id
  project_id = data.stackit_resourcemanager_project.cloudfoundry_project.project_id
}

data "stackit_scf_organization_manager" "scf_manager" {
  project_id = var.project_id
  org_id     = var.org_id
}

data "stackit_scf_platform" "scf_platform" {
  project_id  = var.project_id
  platform_id = data.stackit_scf_organization.scf_org.platform_id
}
