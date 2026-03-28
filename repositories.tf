module "flake_uv_template" {
  source = "./modules/standard_repo"
  name   = "flake-uv-template"
}

module "configuration_apple_os" {
  source      = "./modules/standard_repo"
  name        = "configuration_apple_os"
  description = "Something I can run on any Apple machine to have a working machine"
}

module "home_manager" {
  source = "./modules/standard_repo"
  name   = "home-manager"
}

module "github_settings" {
  source      = "./modules/standard_repo"
  name        = "github-settings"
  description = "ojhermann's GitHub account settings managed as IaC"

  create_codeowners = false # CODEOWNERS is committed directly in the repo via PR
}
