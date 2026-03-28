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
