#!/usr/bin/env bash
# Replaces the 'tofu' command with 'terraform' in all .sh files in this directory.

for file in *.sh; do
  [ "$file" = "use_terraform.sh" ] && continue
  [ "$file" = "use_tofu.sh" ] && continue
  sed -i 's/\btofu\b/terraform/g' "$file"
  echo "Updated: $file"
done
