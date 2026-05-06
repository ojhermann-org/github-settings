variable "flake_bot_app_id" {
  type        = string
  description = "GitHub App ID for the flake-bot (Nix flake.lock updates). Sourced from TF_VAR_flake_bot_app_id."
  sensitive   = true
}

variable "flake_bot_app_private_key" {
  type        = string
  description = "GitHub App private key (PEM) for the flake-bot. Sourced from TF_VAR_flake_bot_app_private_key."
  sensitive   = true
}

module "flake_bot_secrets" {
  source          = "./modules/bot_org_secrets"
  secret_prefix   = "FLAKE_BOT"
  app_id          = var.flake_bot_app_id
  app_private_key = var.flake_bot_app_private_key
  selected_repository_ids = [
    module.fred.repo_id,
  ]
}
