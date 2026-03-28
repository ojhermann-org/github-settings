terraform {
  required_version = ">= 1.10.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }

  # Cloudflare R2 backend via S3-compatible API.
  # Credentials are read from environment variables:
  #   export AWS_ACCESS_KEY_ID="<R2 Access Key ID>"
  #   export AWS_SECRET_ACCESS_KEY="<R2 Secret Access Key>"
  #
  # To find your Account ID: Cloudflare dashboard → R2 → Overview (right sidebar)
  backend "s3" {
    bucket = "tofu-state"
    key    = "github-settings/terraform.tfstate"
    region = "auto"

    endpoints = {
      s3 = "https://962b79861a01e6e071d854c5898d27d5.r2.cloudflarestorage.com"
    }

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true

    # File-based state locking (OpenTofu 1.10+) — sufficient for solo use
    use_lockfile = true
  }
}
