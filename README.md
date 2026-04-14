# Stackit Cloudfoundry OpenTofu/Terraform Template

Template project to manage a CloudFoundry project on Stackit using OpenTofu.

The project consists of 2 OpenTofu projects, where the first project feeds the username and password of the system account that manages the CloudFoundry project into the second one.

If you follow the [official documentation](https://registry.terraform.io/providers/stackitcloud/stackit/latest/docs/guides/scf_cloudfoundry) and create the admin user and the cloudfoundry provider in the same project, than you will run into this error:

```
Error: Unable to create CF Client due to missing values
│ 
│   with provider["registry.terraform.io/cloudfoundry/cloudfoundry"],
│   on stackit.tf line 27, in provider "cloudfoundry":
│   27: provider "cloudfoundry" {
│ 
│ Either user/password or client_id/client_secret or access_token must be set with api_url or CF config must exist in path (default ~/.cf/config.json)
```

## Setup

You must first create a `credentials.json` file in the root of the project from the system account that will create items in stackit. The [documentation](https://registry.terraform.io/providers/stackitcloud/stackit/latest/docs/guides/stackit_org_service_account) has a manual for creating the user.
On the details page of that service account, in the left menu, click `Service Account Keys`, then in the top `Create Service Account Key`. Create the key and when the key is show, click the `Download` button and choose *.json. Save that file as `credentials.json` in the root of your project.

Rename `secrets.template` to `secrets.sh` and fill in the secrets:

This app uses stackit object storage, accessed using the terraform s3 backend. For authentication, provide the Secret and Key:

```
export AWS_SECRET_ACCESS_KEY=""
export AWS_ACCESS_KEY_ID=""
```

Provide the email address of the service account you created earlier:

```
export STACKIT_SERVICE_ACCOUNT_EMAIL="terraform-73hzuni8@sa.stackit.cloud"
export STACKIT_SERVICE_ACCOUNT_KEY_PATH="../credentials.json"
```

In the Stackit Resource Manager find the folder where you want to create your CloudFoundry project, and copy the ID into the parent_container_id.
The clientname will be used to name the project.
the admin_email is the email of the human stackit user that will need to access the cloudfoundry project.

```
export TF_VAR_parent_container_id=""
export TF_VAR_clientname="sampleproject"
export TF_VAR_admin_email="root@example.com"
```

## Run

There are 4 scripts to manage your project:

1. init.sh will init the stackit project and the cloudfoundry project
2. plan.sh will apply the stackit project and then plan the cloudfoundry project
3. apply.sh will apply both projects
4. destroy will first apply the stackit project, then destroy the cloudfoundry project and then destroy the stackit project


# Additional config

All scripts will accept one argument for environment.
The first result is that this will load additional variables from the XXX.tfvars file in the variables folder in both projects. 
It will also name the space that is created like this.
The default environment is 'Test'

# Tofu or Terraform

You can use this project with both OpenTofu or Terraform. Before you start, run `./use_terraform.sh` to switch to terraform. 