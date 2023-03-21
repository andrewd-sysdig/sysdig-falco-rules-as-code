# This is an example tf file showing how you can manage adding excpetions to an OOTB Falco rule in Sysdig Secure

resource "sysdig_secure_rule_falco" "launch_suspicious_network_tool_in_container" {
  name   = "Launch Suspicious Network Tool in Container" # Name of the rule you are adding exceptions to
  append = true # Always needed if you are adding exceptions to an OOTB Rule
  exceptions {
    name   = "proc_name_proc_pname_image_suffix" #name of the exception
    # fields = ["proc.name", "proc.pname", "container.image.repository"]
    # comps  = ["in", "in", "endswith"]
    values = jsonencode([
      [["nc","netcat"], ["bash"], "docker.io/library/ubuntufake"],
      [["dig"], ["bash"], "docker.io/library/nginxfake"]
    ])
  }
}


/*

The above translates to this YAML exception in the Custom Rules file

- rule: Launch Suspicious Network Tool in Container
  desc: ""
  exceptions:
    - name: proc_name_proc_pname_image_suffix
      values:
        - - - nc
            - netcat
          - - bash
          - docker.io/library/ubuntufake
        - - - dig
          - - bash
          - docker.io/library/nginxfake
  output: ""
  priority: WARNING
  append: true

*/