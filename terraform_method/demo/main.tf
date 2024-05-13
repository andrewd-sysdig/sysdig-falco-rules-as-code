terraform {
  required_providers {
    sysdig = {
      source = "sysdiglabs/sysdig"
      version = ">=0.5"
    }
  }
}

provider "sysdig" {
  sysdig_secure_url = "https://app.au1.sysdig.com"
  sysdig_secure_api_token = "46d7ab8e-d7a4-43bc-a8e5-984a15538084"
}
