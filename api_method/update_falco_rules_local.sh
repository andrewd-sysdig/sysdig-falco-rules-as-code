#!/bin/bash

if [ -z "$SECURE_API_TOKEN" ]; then
	echo "Error: SECURE_API_TOKEN environment variable is not set"
    exit 1
fi

if [ -z "$API_ENDPOINT" ]; then
	echo "Error: API_ENDPOINT environment variable is not set. Example export API_ENDPOINT=app.au1.sysdig.com"
    exit 1
fi

if [ ! -f falco_rules_local.yaml ]; then
	echo "falco_rules_local.yaml does not exist in current directory"
    exit 1
fi

FALCO_RULES_FILE="https://${API_ENDPOINT}/api/settings/falco/customRulesFiles/falco_rules_local.yaml"

# Get version of current rules file as this is required to update them
version=$(curl --show-error --request GET --url ${FALCO_RULES_FILE} --header 'content-type: application/json' --header "Authorization: Bearer ${SECURE_API_TOKEN}" | jq .version)

# Get content of the falco_rules_local.yaml and convert to a single line with escaped newline \n characters
# Note: -z doesn't work on MAC - try zsed if you are on MAC
CONTENT=$(cat falco_rules_local.yaml | sed -z 's/\n/\\n/g;s/\\n$/\n/')

# Call the Sysdig customRulesFiles API to push our new rules file 
response=$(curl -w "%{http_code}\n" --silent --output /dev/null --show-error --request PUT --url ${FALCO_RULES_FILE} --header 'content-type: application/json' --header "Authorization: Bearer ${SECURE_API_TOKEN}" \
  -d '{"filename":"falco_rules_local.yaml","content":"'"${CONTENT}"'","version":'"${version}"'}')

# Evaluate reponse from curl and if anything but 200 return failure
if [ "$response" -eq 200 ]; then
  exit 0
else
  exit 1
fi