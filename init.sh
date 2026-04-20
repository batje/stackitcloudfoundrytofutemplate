#!/bin/bash

ENVIRONMENT="${1:-Test}"

export TF_VAR_environment="${ENVIRONMENT}"
export STACKIT_SERVICE_ACCOUNT_KEY_PATH="../credentials.json"

# Source environment exports
source "$(dirname "$0")/secrets.sh"

cd stackit
STACKFOLDER="$(dirname "$0")/variables/${ENVIRONMENT}.tfvars"

if [[ ! -f "$STACKFOLDER" ]]; then
  tofu init -reconfigure
else
  tofu init -reconfigure -var-file="./variables/${ENVIRONMENT}.tfvars"
fi

cd ../cloudfoundry
CLOUDFOLDER="$(dirname "$0")/variables/${ENVIRONMENT}.tfvars"
if [[ ! -f "$CLOUDFOLDER" ]]; then
  tofu init -reconfigure
else
  tofu init -reconfigure -var-file="./variables/${ENVIRONMENT}.tfvars"
fi

cd ../