# Managing your Sysdig Custom Falco Rules as code using a falce rules YAML file and the Sysdig Secure API
Example workflow on how to manage your custom falco rules &amp; exceptions as code

> :warning: I recommend using our [Terraform Provider](../terraform_method/README.md) method to manage your rules rather than this way, but if you are unable to use terraform for whatever reason here you go :) 

- Manage your custom falco rules including exceptions in the `falco_rules_local.yaml` file. 
- Use the `update_falco_rules_local.py` file to push the new file to Sysdig. 
- Warning this will overwrite the Custom Rules file so any changes anyone has made to that file in the UI will be replaced with the contents of this file
- See the [Falco documentation](https://falco.org/docs/rules/) for the syntax of a Falco rule
- Checkout the [free Falco 101 Training](https://falco.org/training/)
- Note the `update_falco_rules_local.sh` doesn't work on MAC due to a requirement for `sed -z`. If you want to run it on mac you need to install and change this to `gsed`
- Note make sure not to use any double quotes " in your falco_rules_local.yaml file

## Usage
Two environment variables are required:
- `SECURE_API_TOKEN` - This is your Sysdig Secure API Token (note this is different to your ACCESS KEY)
- `API_ENDPOINT` - This is the base URL of your Sysdig region

`SECURE_API_TOKEN=xxx API_ENDPOINT=app.au1.sysdig.com python3 update_falco_rules.py`
