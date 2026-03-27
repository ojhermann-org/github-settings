# CLAUDE.md — github-settings

## Purpose

This repo manages ojhermann's personal GitHub account settings as infrastructure-as-code using [OpenTofu](https://opentofu.org) and the [GitHub Terraform provider](https://registry.terraform.io/providers/integrations/github/latest/docs).

## Stack

- **OpenTofu** >= 1.10.0
- **GitHub provider** `integrations/github` ~> 6.0
- **State backend**: Cloudflare R2 (S3-compatible), bucket `tofu-state`, key `github-settings/terraform.tfstate`

## Credentials (never commit these)

| Purpose | Env var |
|---------|---------|
| GitHub token | `GITHUB_TOKEN` |
| R2 access key ID | `AWS_ACCESS_KEY_ID` |
| R2 secret access key | `AWS_SECRET_ACCESS_KEY` |

The GitHub token needs scopes: `repo`, `admin:org`, `delete_repo`, `workflow`.

## Key Files

| File | Purpose |
|------|---------|
| `versions.tf` | Required providers, versions, R2 backend config |
| `provider.tf` | GitHub provider (reads `GITHUB_TOKEN` from env) |
| `variables.tf` | Input variables (`github_owner = "ojhermann"`) |
| `imports.tf` | OpenTofu `import` blocks for onboarding existing repos |
| `repositories.tf` | `github_repository` resources and associated branch protection / Actions config |

## Import Workflow

When onboarding an existing GitHub repo:

1. Add an `import` block to `imports.tf`:
   ```hcl
   import {
     to = github_repository.my_repo
     id = "repo-name-on-github"
   }
   ```
2. Generate resource config from live state:
   ```bash
   tofu plan -generate-config-out=generated_repositories.tf
   ```
3. Review `generated_repositories.tf`, clean up any unwanted attributes, move resource blocks into `repositories.tf`.
4. Run `tofu apply` to record state.
5. Delete `generated_repositories.tf` and remove the corresponding `import` block from `imports.tf`.

## Conventions

- One `github_repository` resource per repo, named with underscores matching the repo slug (e.g. `home-manager` → `github_repository.home_manager`).
- Keep branch protection rules and Actions settings as separate resource blocks directly below their parent `github_repository` resource in `repositories.tf`.
- Do not use `terraform.tfvars` for sensitive values — use environment variables only.
- Commit `.terraform.lock.hcl` so provider versions are pinned across machines.
- Run `tofu fmt` before committing.

## Common Commands

```bash
tofu init          # first-time or after provider changes
tofu fmt           # format all .tf files
tofu validate      # validate config
tofu plan          # preview changes
tofu apply         # apply changes
tofu state list    # list managed resources
```
