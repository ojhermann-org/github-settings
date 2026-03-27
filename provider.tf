provider "github" {
  # Token is read from GITHUB_TOKEN environment variable.
  # The token needs these scopes: repo, admin:org, delete_repo, workflow
  owner = var.github_owner
}
