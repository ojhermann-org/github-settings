resource "github_team" "admins" {
  name                 = "admins"
  description          = "Organization administrators"
  privacy              = "closed"
  notification_setting = "notifications_enabled"
}

resource "github_team_membership" "admins_ojhermann" {
  team_id  = github_team.admins.id
  username = "ojhermann"
  role     = "maintainer"
}
