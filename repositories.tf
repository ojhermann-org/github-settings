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

  required_status_checks = ["lint", "build"] # require CI to pass before merging
}

module "aws_infra" {
  source      = "./modules/standard_repo"
  name        = "aws-infra"
  description = "Managing AWS infrastructure with OpenTofu, following AWS Organizations best practices"

  required_status_checks = ["fmt", "trivy"] # require CI to pass before merging
  create_codeowners      = false            # CODEOWNERS is committed directly in the repo via PR
}

module "github_settings" {
  source      = "./modules/standard_repo"
  name        = "github-settings"
  description = "ojhermann's GitHub account settings managed as IaC"

  create_codeowners = false # CODEOWNERS is committed directly in the repo via PR
}
