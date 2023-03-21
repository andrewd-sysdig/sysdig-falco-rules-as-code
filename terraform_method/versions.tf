terraform {
  required_providers {
    sysdig = {
      source = "sysdiglabs/sysdig"
      version = ">=0.5"
    }
  }
   cloud {
    organization = "andrewd-sysdig"

    workspaces {
      name = "sysdig-falco-rules-as-code"
    }
  }
}