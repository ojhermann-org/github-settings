variable "secret_prefix" {
  type        = string
  description = "Prefix used to name the org secrets (e.g. \"FLAKE_BOT\" produces FLAKE_BOT_APP_ID and FLAKE_BOT_APP_PRIVATE_KEY)."
}

variable "app_id" {
  type        = string
  description = "GitHub App ID for this bot."
  sensitive   = true
}

variable "app_private_key" {
  type        = string
  description = "GitHub App private key (PEM) for this bot."
  sensitive   = true
}

variable "selected_repository_ids" {
  type        = list(number)
  description = "Numeric repo IDs that can read this bot's org secrets."
}
