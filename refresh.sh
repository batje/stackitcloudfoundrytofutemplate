#!/bin/bash


ENVIRONMENT="${1:-Test}"

export TF_VAR_environment="${ENVIRONMENT}"

# Source environment exports
source "$(dirname "$0")/secrets.sh"
export STACKIT_SERVICE_ACCOUNT_KEY_PATH="../credentials.json"
echo "Using environment: ${ENVIRONMENT}"

echo "Using cloudfoundry variables from: ${CLOUDFOLDER}"

cd stackit
STACKFOLDER="$(dirname "$0")/variables/${ENVIRONMENT}.tfvars"

if [[ ! -f "$STACKFOLDER" ]]; then
  echo "Not using additional variables, as ${STACKFOLDER} does not exist"
  tofu refresh 
  tofu apply
else
  echo "Using variables from ${STACKFOLDER}"
  tofu refresh  -var-file="./variables/${ENVIRONMENT}.tfvars"
  tofu apply -var-file="./variables/${ENVIRONMENT}.tfvars"
fi

export TF_VAR_org_id=$(tofu output -raw cloudfoundry_org_id)
export TF_VAR_project_id=$(tofu output -raw cloudfoundry_project_id)
export TF_VAR_username=$(tofu output -raw cloudfoundry_user_username)
export TF_VAR_password=$(tofu output -raw cloudfoundry_user_password)

cd ../cloudfoundry
CLOUDFOLDER="$(dirname "$0")/variables/${ENVIRONMENT}.tfvars"

if [[ ! -f "$CLOUDFOLDER" ]]; then
  tofu refresh 
else
  tofu refresh  -var-file="./variables/${ENVIRONMENT}.tfvars"
fi

cd ../