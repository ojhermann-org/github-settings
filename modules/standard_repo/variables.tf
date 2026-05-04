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

variable "license_template" {
  description = "GitHub license template keyword used when the repository is created (e.g. 'apache-2.0', 'mit'). Only applied on initial creation; ignored on subsequent runs so existing repos do not drift."
  type        = string
  default     = "apache-2.0"
}

variable "topics" {
  description = "GitHub topics to attach to the repository, used for discoverability."
  type        = list(string)
  default     = []
}
