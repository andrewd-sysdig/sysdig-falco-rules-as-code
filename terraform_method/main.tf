# Configure and authenticate to the Sysdig provider
# export TF_VAR_sysdig_secure_api_token=xxxxxx
# export TF_VAR_sysdig_saas_region=https://app.au1.sysdig.com

provider "sysdig" {
  sysdig_secure_url = var.sysdig_saas_region
  sysdig_secure_api_token = var.sysdig_secure_api_token
}