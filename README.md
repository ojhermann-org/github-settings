# github-settings

Manages ojhermann's GitHub account settings via [OpenTofu](https://opentofu.org) using the [GitHub provider](https://registry.terraform.io/providers/integrations/github/latest/docs).

## Prerequisites

- [OpenTofu](https://opentofu.org/docs/intro/install/) >= 1.10
- A GitHub personal access token with scopes: `repo`, `admin:org`, `delete_repo`, `workflow`
- A Cloudflare account with R2 enabled

## Setup

### 1. Create the R2 bucket

In the Cloudflare dashboard: **R2 → Create bucket**, name it `tofu-state`.

### 2. Get your Account ID

Cloudflare dashboard → R2 → Overview — your Account ID is in the right sidebar.
Replace `REPLACE_WITH_CLOUDFLARE_ACCOUNT_ID` in `versions.tf`.

### 3. Create an R2 API token

Cloudflare dashboard → R2 → Manage R2 API Tokens → Create API Token.
Give it **Object Read & Write** permission scoped to the `tofu-state` bucket.

### 4. Authenticate

```bash
# R2 credentials (used as S3-compatible access keys)
export AWS_ACCESS_KEY_ID="<R2 Access Key ID>"
export AWS_SECRET_ACCESS_KEY="<R2 Secret Access Key>"

# GitHub token
export GITHUB_TOKEN="ghp_..."
```

### 5. Initialize

```bash
tofu init
```

## Importing Existing Resources

Import blocks are defined in `imports.tf`. To generate resource config from live GitHub state:

```bash
tofu plan -generate-config-out=generated_repositories.tf
```

Review `generated_repositories.tf`, move the resource blocks you want to keep into `repositories.tf`, then:

```bash
tofu apply
```

After a successful apply, delete `generated_repositories.tf` and remove the corresponding `import` blocks from `imports.tf`.

## Day-to-day Usage

```bash
export GITHUB_TOKEN="ghp_..."
tofu plan   # preview changes
tofu apply  # apply changes
```

## Managed Resources

| Resource | File |
|----------|------|
| Repositories | `repositories.tf` |
| Branch protection | `repositories.tf` (alongside repo resources) |
| Actions settings | `repositories.tf` |
