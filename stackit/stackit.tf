resource "stackit_resourcemanager_project" "cloudfoundry_project" {
  parent_container_id = var.parent_container_id
  name                = var.clientname
  labels = {
    "Developer" = "batje"
    // "networkArea" = stackit_network_area.foo.network_area_id
  }
  owner_email = var.admin_email
}

resource "stackit_scf_organization" "scf_org" {
  name       = var.clientname
  project_id = stackit_resourcemanager_project.cloudfoundry_project.project_id
}

data "stackit_scf_platform" "scf_platform" {
  project_id  = stackit_resourcemanager_project.cloudfoundry_project.project_id
  platform_id = stackit_scf_organization.scf_org.platform_id
}

resource "stackit_scf_organization_manager" "scf_manager" {
  project_id = stackit_resourcemanager_project.cloudfoundry_project.project_id
  org_id     = stackit_scf_organization.scf_org.org_id
}
