# This is an example tf file showing how you can manage adding multiple excpetions to an OOTB Falco rule in Sysdig Secure

resource "sysdig_secure_rule_falco" "launch_package_managment_process_in_container" {
  name   = "Launch Package Management Process in Container" # Name of the rule you are adding exceptions to
  append = true # Always needed if you are adding exceptions to an OOTB Rule
  exceptions {
    name   = "container_name_image_prefix" #name of the exception
    # fields: [container.name, container.image.repository]
    # comps: [contains, startswith]
    values = jsonencode([
      ["ubuntu", "docker.io/library/ubuntufake"],
      ["nginx", "docker.io/library/nginxfake"]
   ])
  }
  exceptions {
    name   = "proc_name_image_prefix" #name of the exception
    # fields: [proc.name, container.image.repository]
    # comps: [in, startswith]
    values = jsonencode([
      ["apt", "docker.io/library/ubuntufake"]
   ])
  }
}


/*

The above translates to this YAML exception in the Custom Rules file

- rule: Launch Package Management Process in Container
  desc: ""
  exceptions:
    - name: container_name_image_prefix
      values:
        - - ubuntu
          - docker.io/library/ubuntufake
        - - nginx
          - docker.io/library/nginxfake
    - name: proc_name_image_prefix
      values:
        - - apt
          - docker.io/library/ubuntufake
  output: ""
  priority: WARNING
  append: true

*/