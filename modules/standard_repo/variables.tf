variable "name" {
  description = "Repository name on GitHub (e.g. 'my-repo')"
  type        = string
}

variable "description" {
  description = "Short description of the repository"
  type        = string
  default     = ""
}

variable "homepage_url" {
  description = "URL of the repository homepage"
  type        = string
  default     = ""
}

variable "required_status_checks" {
  description = "List of CI check names that must pass before merging to the default branch. Empty list disables this ruleset."
  type        = list(string)
  default     = []
}

variable "create_codeowners" {
  description = "Whether to manage the CODEOWNERS file via tofu. Set to false for repos where the file is committed directly (e.g. the IaC repo itself, which requires a PR to push to main)."
  type        = bool
  default     = true
}

variable "visibility" {
  description = "Repository visibility: 'public' or 'private'."
  type        = string
  default     = "public"

  validation {
    condition     = contains(["public", "private"], var.visibility)
    error_message = "visibility must be 'public' or 'private'."
  }
}
