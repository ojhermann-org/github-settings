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

  required_status_checks = ["fmt", "trivy", "plan (management)", "plan (dev)", "plan (stage)", "plan (prod)"] # require CI to pass before merging
  create_codeowners      = false                                                                              # CODEOWNERS is committed directly in the repo via PR
}

module "github_settings" {
  source      = "./modules/standard_repo"
  name        = "github-settings"
  description = "ojhermann's GitHub account settings managed as IaC"

  create_codeowners      = false                    # CODEOWNERS is committed directly in the repo via PR
  required_status_checks = ["fmt", "trivy", "plan"] # require CI to pass before merging
}

module "curriculum_vitae" {
  source      = "./modules/standard_repo"
  name        = "curriculum-vitae"
  description = "Otto Hermann's CV, written in LaTeX"
  visibility  = "private" # personal document, not for public consumption
}

module "personal_website" {
  source                 = "./modules/standard_repo"
  name                   = "personal-website"
  description            = "Otto Hermann's personal website, built with Astro and deployed to Cloudflare Pages."
  homepage_url           = "https://otto-hermann.me"
  create_codeowners      = true
  required_status_checks = ["ci"]
}

module "notes" {
  source      = "./modules/standard_repo"
  name        = "notes"
  description = "Notes I'd like to have accessible across devices"
  visibility  = "private"
}
