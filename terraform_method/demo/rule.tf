resource "sysdig_secure_rule_falco" "example" {
  name        = "[Terraform] Terminal shell in container" // ID
  description = "A shell was used as the entrypoint/exec point into a container with an attached terminal."
  tags        = ["container", "shell", "mitre_execution"]

  condition = "spawned_process and container and shell_procs and proc.tty != 0 and container_entrypoint"
  output    = "A shell was spawned in a container with an attached terminal (user=%user.name %container.info shell=%proc.name parent=%proc.pname cmdline=%proc.cmdline terminal=%proc.tty container_id=%container.id image=%container.image.repository)"
  priority  = "notice"
  source    = "syscall" // syscall, k8s_audit, aws_cloudtrail, gcp_auditlog, azure_platformlogs, awscloudtrail okta, github


  exceptions {
    name   = "proc_names"
    fields = ["proc.name"]
    comps  = ["in"]
    values = jsonencode([[["python", "python2", "python3"]]]) # If only one element is provided, it should still needs to be specified as a list of lists.
  }

  exceptions {
    name   = "container_proc_name"
    fields = ["container.id", "proc.name"]
    comps  = ["=", "in"]
    values = jsonencode([ # If more than one element is provided, you need to specify a list of lists.
      ["host", ["docker_binaries", "k8s_binaries", "lxd_binaries", "nsenter"]]
    ])
  }

  exceptions {
    name   = "proc_cmdline"
    fields = ["proc.name", "proc.cmdline"]
    comps  = ["in", "contains"]
    values = jsonencode([ # In this example, we are providing a pair of values for proc_cmdline, each one in a line.
      [["python", "python2", "python3"], "/opt/draios/bin/sdchecks"],
      [["java"], "sdjagent.jar"]
    ])
  }
}