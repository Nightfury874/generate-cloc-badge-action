#!/bin/bash
set -e

# Input variables
GITHUB_TOKEN="$1"
TARGET_BRANCH="$2"
GITHUB_REPOSITORY="${GITHUB_REPOSITORY}"

# Configure git
git config --global user.email "github-actions[bot]@users.noreply.github.com"
git config --global user.name "github-actions[bot]"

# Generate cloc.json in /tmp
cloc --json . > /tmp/cloc_temp.json

# Fetch all branches
git fetch origin

# Check if target branch exists
if git ls-remote --heads origin "$TARGET_BRANCH" | grep -q "$TARGET_BRANCH"; then
    echo "Branch '$TARGET_BRANCH' exists. Checking it out."
    git checkout "$TARGET_BRANCH"
    git pull origin "$TARGET_BRANCH"
else
    echo "Branch '$TARGET_BRANCH' does not exist. Creating it."
    git checkout --orphan "$TARGET_BRANCH"
    git rm -rf .
    echo "# $TARGET_BRANCH branch" > README.md
    git add README.md
    git commit -m "Initialize $TARGET_BRANCH branch"
    git push "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" "$TARGET_BRANCH"
fi

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
git push "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" "$TARGET_BRANCH"
