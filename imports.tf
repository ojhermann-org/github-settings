# Import blocks for existing repositories.
# After running `tofu init`, generate resource config with:
#   tofu plan -generate-config-out=generated_repositories.tf
# Review the generated file, then move resources into repositories.tf and delete this import block.

import {
  to = github_repository.home_manager
  id = "home-manager"
}

import {
  to = github_repository.flake_uv_template
  id = "flake-uv-template"
}

import {
  to = github_repository.configuration_apple_os
  id = "configuration_apple_os"
}
