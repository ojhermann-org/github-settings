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
| `provider.tf` | GitHub provider (owner hardcoded as `ojhermann-org`, token from `GITHUB_TOKEN`) |
| `imports.tf` | OpenTofu `import` blocks for onboarding existing resources (must be present during `tofu apply`) |
| `organization.tf` | Org-level settings: `github_organization_settings` and `github_organization_ruleset` |
| `repositories.tf` | One `module` call per repo — `name` and optional `description` only |
| `modules/standard_repo/` | All repo defaults: `github_repository` + CODEOWNERS file, owner hardcoded as `ojhermann-org` |

## Branch Protection Strategy

Branch protection is handled at the org level via `github_organization_ruleset.default_branch` in `organization.tf`. It targets `~DEFAULT_BRANCH` across `~ALL` repos, so new repos are automatically covered. There are no per-repo `github_branch_protection` resources.

## Repo Conventions

- One `module "<slug>"` call per repo in `repositories.tf`, using `./modules/standard_repo`. Pass `name` and `description` (omit `description` if empty).
- All standard settings (security scanning, CODEOWNERS, merge strategy, etc.) are defined once in `modules/standard_repo/main.tf`.
- To deviate from the standard for a specific repo, add a variable to the `standard_repo` module and pass an override in `repositories.tf` with a comment explaining why.
- Do not use `terraform.tfvars` for sensitive values — use environment variables only.
- Commit `.terraform.lock.hcl` so provider versions are pinned across machines.
- Run `tofu fmt` before committing.

## Import Workflow

When onboarding an existing GitHub resource:

1. Add an `import` block to `imports.tf`:
   ```hcl
   import {
     to = module.my_repo.github_repository.repo
     id = "repo-name-on-github"
   }
   ```
2. Add a matching `module` call to `repositories.tf`.
3. Run `tofu plan` to verify, then `tofu apply`.
4. Remove the import block from `imports.tf`.

## Common Commands

```bash
tofu init          # first-time or after provider changes
tofu fmt           # format all .tf files
tofu validate      # validate config
tofu plan          # preview changes
tofu apply         # apply changes
tofu state list    # list managed resources
```
