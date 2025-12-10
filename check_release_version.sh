#!/bin/bash

get_latest_release() {
  local repo=$1
  if [ -z "$repo" ]; then
    echo "Error: Repository name (owner/repo) is required." >&2
    return 1
  fi
  
  # GitHub API endpoint for the latest release
  local api_url="https://api.github.com/repos/${repo}/releases/latest"
  
  local tag=$(curl -sL "$api_url" | jq -r .tag_name)
  
  if [ "$tag" == "null" ] || [ -z "$tag" ]; then
    echo "Error: Could not retrieve latest release tag for $repo." >&2
    return 1
  fi
  
  echo "$tag"
}


OWNER_REPO="wazuh/wazuh-docker"

LATEST_TAG=$(get_latest_release "$OWNER_REPO")

if [ $? -eq 0 ]; then
  echo "---"
  echo "Repository: $OWNER_REPO"
  echo "Latest Release Tag: $LATEST_TAG"
  echo "---"
  echo "Downloading latest release"
  git clone --quiet -c advice.detachedHead=false https://github.com/wazuh/wazuh-docker.git -b $LATEST_TAG
  cd wazuh-docker/single-node && docker compose -f generate-indexer-certs.yml run --rm generator
else
  echo "Failed to get latest release."
fi
