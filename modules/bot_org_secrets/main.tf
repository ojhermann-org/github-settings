resource "github_actions_organization_secret" "app_id" {
  secret_name     = "${var.secret_prefix}_APP_ID"
  visibility      = "selected"
  plaintext_value = var.app_id
}

resource "github_actions_organization_secret_repositories" "app_id" {
  secret_name             = github_actions_organization_secret.app_id.secret_name
  selected_repository_ids = var.selected_repository_ids
}

resource "github_actions_organization_secret" "app_private_key" {
  secret_name     = "${var.secret_prefix}_APP_PRIVATE_KEY"
  visibility      = "selected"
  plaintext_value = var.app_private_key
}

resource "github_actions_organization_secret_repositories" "app_private_key" {
  secret_name             = github_actions_organization_secret.app_private_key.secret_name
  selected_repository_ids = var.selected_repository_ids
}
