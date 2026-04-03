resource "github_repository" "repo" {
  name         = var.name
  description  = var.description
  homepage_url = var.homepage_url

  visibility             = var.visibility
  archive_on_destroy     = false
  archived               = false
  auto_init              = true
  allow_auto_merge       = true
  allow_merge_commit     = false # org ruleset only permits squash and rebase
  allow_rebase_merge     = true
  allow_squash_merge     = true
  allow_update_branch    = false
  delete_branch_on_merge = true
  has_discussions        = false
  has_issues             = true
  has_projects           = true
  has_wiki               = false
  is_template            = false

  merge_commit_message        = "PR_TITLE"
  merge_commit_title          = "MERGE_MESSAGE"
  squash_merge_commit_message = "COMMIT_MESSAGES"
  squash_merge_commit_title   = "COMMIT_OR_PR_TITLE"

  topics                      = []
  vulnerability_alerts        = true
  web_commit_signoff_required = false

  dynamic "security_and_analysis" {
    for_each = var.visibility == "public" ? [1] : []
    content {
      secret_scanning {
        status = "enabled"
      }
      secret_scanning_push_protection {
        status = "enabled"
      }
    }
  }
}

resource "github_repository_ruleset" "branch_naming" {
  name        = "branch-naming"
  repository  = github_repository.repo.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~ALL"]
      exclude = ["~DEFAULT_BRANCH"]
    }
  }

  rules {
    branch_name_pattern {
      operator = "regex"
      pattern  = "^(feat|fix|chore|docs|refactor)/.*"
    }
  }
}

resource "github_repository_ruleset" "ci_checks" {
  count = length(var.required_status_checks) > 0 ? 1 : 0

  name        = "ci-checks"
  repository  = github_repository.repo.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    required_status_checks {
      strict_required_status_checks_policy = true

      dynamic "required_check" {
        for_each = var.required_status_checks
        content {
          context = required_check.value
        }
      }
    }
  }
}

resource "github_repository_file" "codeowners" {
  count = var.create_codeowners ? 1 : 0

  repository          = github_repository.repo.name
  branch              = "main"
  file                = "CODEOWNERS"
  content             = "* @ojhermann-org\n"
  commit_message      = "Add CODEOWNERS"
  overwrite_on_create = true

  lifecycle {
    ignore_changes = [commit_message]
  }
}
