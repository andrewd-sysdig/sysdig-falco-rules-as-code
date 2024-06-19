# Make sure to have 2 environment variables set
# export SECURE_API_TOKEN="<Your Sysdig Secure API Token>"
# export API_ENDPOINT="app.au1.sysdig.com"

import requests
import os

# Global Variables
SECURE_API_TOKEN = os.getenv('SECURE_API_TOKEN')
API_ENDPOINT = os.getenv('API_ENDPOINT')
FALCO_RULES_PATH = "/api/settings/falco/customRulesFiles/falco_rules_local.yaml"
URL = "https://" + API_ENDPOINT + FALCO_RULES_PATH
API_HEADERS = {
  'Authorization': 'Bearer ' + SECURE_API_TOKEN,
  'Content-Type': 'application/json'
}

def get_current_version_of_remote_rules_file():
    response = requests.get(URL, headers=API_HEADERS)
    if response.status_code != 200:
        exit_on_error(response.status_code, response.text)
    version = response.json()["version"]
    return version

def get_local_rules_file_as_single_string():
    with open("falco_rules_local.yaml", 'r') as rules_file:
        rules_file_single_string = '\n'.join(rules_file.read().splitlines()) + '\n'
    return rules_file_single_string

def update_remote_rules_file():
    remote_rules_version = get_current_version_of_remote_rules_file()
    rules_file_single_string = get_local_rules_file_as_single_string()
    data = {"filename":"falco_rules_local.yaml","content":rules_file_single_string,"version":remote_rules_version}
    response = requests.put(URL, headers=API_HEADERS, json=data)
    if response.status_code != 200:
        exit_on_error(response.status_code, response.text)

def exit_on_error(status_code, response_text):
        print("The Sysdig API did not return a HTTP 200 (OK) response. Response Code: {0}, Response Text: {1}".format(status_code, response_text))
        exit()

def main():
    update_remote_rules_file()

if __name__ == '__main__':
    main()