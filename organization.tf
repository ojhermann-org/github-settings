resource "github_organization_settings" "settings" {
  billing_email                                                = "ojhermann@gmail.com"
  default_repository_permission                                = "read"
  has_organization_projects                                    = true
  has_repository_projects                                      = true
  members_can_create_internal_repositories                     = false
  members_can_create_pages                                     = false
  members_can_create_private_pages                             = false
  members_can_create_private_repositories                      = false
  members_can_create_public_pages                              = false
  members_can_create_public_repositories                       = false
  members_can_create_repositories                              = false
  members_can_fork_private_repositories                        = false
  web_commit_signoff_required                                  = false
  advanced_security_enabled_for_new_repositories               = false
  dependabot_alerts_enabled_for_new_repositories               = true
  dependabot_security_updates_enabled_for_new_repositories     = true
  dependency_graph_enabled_for_new_repositories                = true
  secret_scanning_enabled_for_new_repositories                 = true
  secret_scanning_push_protection_enabled_for_new_repositories = true
}

resource "github_actions_organization_workflow_permissions" "settings" {
  organization_slug                = "ojhermann-org"
  default_workflow_permissions     = "read"
  can_approve_pull_request_reviews = true
}

resource "github_organization_ruleset" "default_branch" {
  name        = "default-branch"
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      exclude = []
      include = ["~DEFAULT_BRANCH"]
    }

    repository_name {
      exclude = []
      include = ["~ALL"]
    }
  }

  bypass_actors {
    actor_id    = 1
    actor_type  = "OrganizationAdmin"
    bypass_mode = "always"
  }

  rules {
    deletion                = true
    required_linear_history = true
    non_fast_forward        = true

    pull_request {
      allowed_merge_methods             = ["squash", "rebase"]
      require_code_owner_review         = true
      required_approving_review_count   = 0
      required_review_thread_resolution = true
      dismiss_stale_reviews_on_push     = false
      require_last_push_approval        = false
    }

    required_status_checks {
      strict_required_status_checks_policy = false

      required_check {
        context = "ci"
      }
    }
  }
}
