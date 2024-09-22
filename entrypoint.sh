#!/bin/bash
set -e

# Input variables
GITHUB_TOKEN="$1"
TARGET_BRANCH="$2"

# Configure git
git config --global user.email "github-actions[bot]@users.noreply.github.com"
git config --global user.name "github-actions[bot]"

# Install dependencies
apt-get update
apt-get install -y cloc jq

# Generate cloc.json in /tmp
cloc --json . > /tmp/cloc_temp.json

# Fetch all branches and switch to target branch
git fetch origin
git checkout -B "$TARGET_BRANCH" origin/"$TARGET_BRANCH" || git checkout -b "$TARGET_BRANCH"

# Copy cloc.json to working directory
cp /tmp/cloc_temp.json cloc.json

# Generate badge data
LINES=$(jq '.SUM.code' cloc.json)
cat <<EOF > cloc.json
{
  "schemaVersion": 1,
  "label": "Total Lines",
  "message": "$LINES",
  "color": "blue"
}
EOF

# Commit and push changes
git add cloc.json
git commit -m "Update cloc data" || echo "No changes to commit"
git push origin "$TARGET_BRANCH"
