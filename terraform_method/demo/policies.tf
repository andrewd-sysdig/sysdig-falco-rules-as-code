resource "sysdig_secure_policy" "write_apt_database" {
  name = "[Terraform] Write apt database"
  description = "an attempt to write to the dpkg database by any non-dpkg related program"
  severity = 4
  enabled = false
  runbook = "https://runbook.com"

  // Scope selection
  scope = "container.id != \"\""

  // Rule selection
  rule_names = ["[Terraform] Terminal shell in container"]

  actions {
    container = "stop"
    capture {
      name = "demo_capture"
      seconds_before_event = 5
      seconds_after_event = 10
    }
  }

  notification_channels = [33579]
}