#!/usr/bin/env bash
# Replaces the 'terraform' command with 'tofu' in all .sh files in this directory.

for file in *.sh; do
  [ "$file" = "use_terraform.sh" ] && continue
  [ "$file" = "use_tofu.sh" ] && continue
  sed -i 's/\bterraform\b/tofu/g' "$file"
  echo "Updated: $file"
done
