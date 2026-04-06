# Add import blocks here when onboarding existing GitHub resources.
# Workflow:
#   1. Add import block(s)
#   2. Add matching module/resource to repositories.tf or organization.tf
#   3. Run tofu plan to verify, then tofu apply (import block must still be present)
#   4. Remove import blocks after successful apply

import {
  to = module.github_settings.github_repository.repo
  id = "github-settings"
}

import {
  to = module.effective_haskell.github_repository.repo
  id = "effective-haskell"
}
