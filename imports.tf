# Add import blocks here when onboarding existing GitHub resources.
# Workflow:
#   1. Add import block(s)
#   2. tofu plan -generate-config-out=generated_repositories.tf
#   3. Review, clean up, move resources into repositories.tf (or organization.tf)
#   4. tofu apply  (import block must still be present)
#   5. Remove import blocks after successful apply

import {
  to = github_organization_settings.settings
  id = "ojhermann-org"
}
