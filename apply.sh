#!/bin/bash

ENVIRONMENT="${1:-Test}"

export TF_VAR_environment="${ENVIRONMENT}"
export STACKIT_SERVICE_ACCOUNT_KEY_PATH="../credentials.json"

# Source environment exports
source "$(dirname "$0")/secrets.sh"

STACKFOLDER="$(dirname "$0")/stackit/variables/${ENVIRONMENT}.tfvars"
CLOUDFOLDER="$(dirname "$0")/cloudfoundry/variables/${ENVIRONMENT}.tfvars"

cd stackit

if [[ ! -f "$STACKFOLDER" ]]; then
  tofu plan 
  tofu apply
else 
  tofu plan  -var-file="./variables/${ENVIRONMENT}.tfvars"
  tofu apply -var-file="./variables/${ENVIRONMENT}.tfvars"
fi

export TF_VAR_org_id=$(tofu output -raw cloudfoundry_org_id)
export TF_VAR_project_id=$(tofu output -raw cloudfoundry_project_id)
export TF_VAR_username=$(tofu output -raw cloudfoundry_user_username)
export TF_VAR_password=$(tofu output -raw cloudfoundry_user_password)

cd ../cloudfoundry

if [[ ! -f "$CLOUDFOLDER" ]]; then
  tofu apply
else
  tofu plan  -var-file="./variables/${ENVIRONMENT}.tfvars"
fi

cd ../