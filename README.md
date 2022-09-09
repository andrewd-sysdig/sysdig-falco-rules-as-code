# Managing your Sysdig Custom Falco Rules as code
Example workflow on how to manage your custom falco rules &amp; exceptions as code

- Manage your custom falco rules including exceptions in the `falco_rules_local.yaml` file. 
- Use the `update_falco_rules_local.sh` file to push the new file to Sysdig. 
- Warning this will overwrite the Custom Rules file so any changes anyone has made to that file in the UI will be replaced with the contents of this file
- See the [Falco documentation](https://falco.org/docs/rules/) for the syntax of a Falco rule
- Checkout the [free Falco 101 Training](https://falco.org/training/)

## Usage
Two environment variables are required:
- `SECURE_API_TOKEN` - This is your Sysdig Secure API Token (note this is different to your ACCESS KEY)
- `API_ENDPOINT` - This is the base URL of your Sysdig region

`SECURE_API_TOKEN=xxx API_ENDPOINT=app.au1.sysdig.com ./update_falco_rules_local.sh`
