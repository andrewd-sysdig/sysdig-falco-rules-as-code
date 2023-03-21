# This is an example tf file showing how you can manage appending to OOTB falco lists for Sysdig Secure

resource "sysdig_secure_list" "allowed_namespaces" {
  name = "allowed_namespaces" # Name of the list you are appending values to
  items = ["kube-system", "sock-shop", "app123"]
  append = true # Always needed if you are appending to an OOTB falco list
}

/* 

The above translates to this YAML exception in the Custom Rules file

- list: allowed_namespaces
  items: [kube-system, sock-shop, app123]
  append: true

*/