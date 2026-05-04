module "configuration_apple_os" {
  source      = "./modules/standard_repo"
  name        = "configuration_apple_os"
  description = "Something I can run on any Apple machine to have a working machine"
}

module "home_manager" {
  source = "./modules/standard_repo"
  name   = "home-manager"
}

module "aws_infra" {
  source      = "./modules/standard_repo"
  name        = "aws-infra"
  description = "Managing AWS infrastructure with OpenTofu, following AWS Organizations best practices"
}

module "github_settings" {
  source      = "./modules/standard_repo"
  name        = "github-settings"
  description = "ojhermann's GitHub account settings managed as IaC"
}

module "curriculum_vitae" {
  source      = "./modules/standard_repo"
  name        = "curriculum-vitae"
  description = "Otto Hermann's CV, written in LaTeX"
  visibility  = "private" # personal document, not for public consumption
}

module "personal_website" {
  source       = "./modules/standard_repo"
  name         = "personal-website"
  description  = "Otto Hermann's personal website, built with Astro and deployed to Cloudflare Pages."
  homepage_url = "https://otto-hermann.me"
}

module "notes" {
  source      = "./modules/standard_repo"
  name        = "notes"
  description = "Notes I'd like to have accessible across devices"
  visibility  = "private"
}

module "fred" {
  source      = "./modules/standard_repo"
  name        = "fred"
  description = "A library for wokring with https://fred.stlouisfed.org/docs/api/fred/"
  visibility  = "public"
}
