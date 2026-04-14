#!/bin/bash

ENVIRONMENT="${1:-Test}"

export TF_VAR_environment="${ENVIRONMENT}"

# Source environment exports
source "$(dirname "$0")/secrets.sh"

STACKFOLDER="$(dirname "$0")/stackit/variables/${ENVIRONMENT}.tfvars"
CLOUDFOLDER="$(dirname "$0")/cloudfoundry/variables/${ENVIRONMENT}.tfvars"

cd stackit

if [[ ! -f "$STACKFOLDER" ]]; then
  tofu init -reconfigure
else
  tofu init -reconfigure -var-file="./variables/${ENVIRONMENT}.tfvars"
fi

cd ../cloudfoundry

if [[ ! -f "$CLOUDFOLDER" ]]; then
  tofu init -reconfigure 
else
  tofu init -reconfigure -var-file="./variables/${ENVIRONMENT}.tfvars"
fi

cd ../