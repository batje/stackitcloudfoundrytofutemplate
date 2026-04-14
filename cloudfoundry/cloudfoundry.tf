

provider "cloudfoundry" {
  api_url  = data.stackit_scf_platform.scf_platform.api_url
  user     = var.username
  password = var.password
}

resource "cloudfoundry_org_role" "org_user" {
  username = var.admin_email
  type     = "organization_user"
  org      = data.stackit_scf_organization.scf_org.org_id
}

resource "cloudfoundry_org_role" "org_manager" {
  username = var.admin_email
  type     = "organization_manager"
  org      = data.stackit_scf_organization.scf_org.org_id
}

resource "cloudfoundry_org_role" "org_user_system" {
  username = data.stackit_scf_organization_manager.scf_manager.username
  type     = "organization_user"
  org      = data.stackit_scf_organization.scf_org.org_id
}

/*
resource "cloudfoundry_org_role" "org_manager_system" {
  username = data.stackit_scf_organization_manager.scf_manager.username
  type     = "organization_manager"
  org      = data.stackit_scf_organization.scf_org.org_id
}
*/
resource "cloudfoundry_space_role" "space_developer_terraform" {
  username   = data.stackit_scf_organization_manager.scf_manager.username
  type       = "space_developer"
  depends_on = [cloudfoundry_org_role.org_user_system]
  space      = cloudfoundry_space.space.id
}

resource "cloudfoundry_space" "space" {
  name = var.environment
  org  = data.stackit_scf_organization.scf_org.org_id
}
