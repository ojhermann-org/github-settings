output "repo_id" {
  description = "Numeric repository database ID, used for org-secret visibility lists."
  value       = github_repository.repo.repo_id
}
