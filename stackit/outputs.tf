output "cloudfoundry_org_id" {
  value     = stackit_scf_organization.scf_org.org_id
  sensitive = false
}

output "cloudfoundry_project_id" {
  value     = stackit_resourcemanager_project.cloudfoundry_project.project_id
  sensitive = false
}

output "cloudfoundry_user_username" {
  value     = stackit_scf_organization_manager.scf_manager.username
  sensitive = false
}

output "cloudfoundry_user_password" {
  value     = stackit_scf_organization_manager.scf_manager.password
  sensitive = true
}
