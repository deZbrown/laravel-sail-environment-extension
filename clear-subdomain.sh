#!/bin/bash

# Step 1: Remove the Submodule Entry
# Remove the submodule entry from .gitmodules
sed -i '/docker/,+2d' .gitmodules

# Remove the submodule entry from Git's configuration
git config -f .git/config --remove-section submodule.docker

# Step 2: Unstage the Submodule and Sync
# Unstage the submodule and commit the removal
git rm --cached docker
git commit -m "Remove submodule entry for docker"

# Step 3: Delete Submodule Files and Folders
# Remove the submodule's metadata from the repository
rm -rf .git/modules/docker

# Step 4: Convert Submodule to Regular Files
# Ensure contents are safe before deleting
cp -r docker docker_backup
rm -rf docker
mv docker_backup docker

# Add the previously submodule directory to your repository as normal files
git add docker
git commit -m "Add former submodule files as regular project files"

# Step 5: Push Changes
# Push changes to the remote repository
git push

echo "Submodule has been converted to regular files and changes pushed."
