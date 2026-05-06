variable "bot_app_id" {
  type        = string
  description = "GitHub App ID for the shared automation bot (e.g. flake-bot). Sourced from TF_VAR_bot_app_id."
  sensitive   = true
}

variable "bot_app_private_key" {
  type        = string
  description = "GitHub App private key (PEM) for the shared automation bot. Sourced from TF_VAR_bot_app_private_key."
  sensitive   = true
}

locals {
  bot_secret_repo_ids = [
    module.fred.repo_id,
  ]
}

resource "github_actions_organization_secret" "bot_app_id" {
  secret_name     = "BOT_APP_ID"
  visibility      = "selected"
  plaintext_value = var.bot_app_id
}

resource "github_actions_organization_secret_repositories" "bot_app_id" {
  secret_name             = github_actions_organization_secret.bot_app_id.secret_name
  selected_repository_ids = local.bot_secret_repo_ids
}

resource "github_actions_organization_secret" "bot_app_private_key" {
  secret_name     = "BOT_APP_PRIVATE_KEY"
  visibility      = "selected"
  plaintext_value = var.bot_app_private_key
}

resource "github_actions_organization_secret_repositories" "bot_app_private_key" {
  secret_name             = github_actions_organization_secret.bot_app_private_key.secret_name
  selected_repository_ids = local.bot_secret_repo_ids
}
