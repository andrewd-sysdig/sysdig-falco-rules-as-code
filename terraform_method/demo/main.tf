terraform {
  required_providers {
    sysdig = {
      source = "sysdiglabs/sysdig"
      version = ">=0.5"
    }
  }
}

provider "sysdig" {
  sysdig_secure_url = <SYSDIG_SECURE_URL>
  sysdig_secure_api_token = <SYSDIG_SECURE_API_TOKEN>
}
