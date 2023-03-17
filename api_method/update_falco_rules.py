import requests
import os

# Global Variables
SECURE_API_TOKEN = os.getenv('SECURE_API_TOKEN')
BASE_API_URL = "https://au1.app.sysdig.com" 
FALCO_RULES_PATH = "/api/settings/falco/customRulesFiles/falco_rules_local.yaml"
API_HEADERS = {
  'Authorization': 'Bearer ' + SECURE_API_TOKEN,
  'Content-Type': 'application/json'
}

def get_current_version_of_remote_rules_file():
    url = BASE_API_URL + FALCO_RULES_PATH 
    response = requests.get(url, headers=API_HEADERS)
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
    url = BASE_API_URL + FALCO_RULES_PATH 
    data = {"filename":"falco_rules_local.yaml","content":rules_file_single_string,"version":remote_rules_version}
    response = requests.put(url, headers=API_HEADERS, json=data)
    if response.status_code != 200:
        exit_on_error(response.status_code, response.text)

def exit_on_error(status_code, response_text):
        print("The Sysdig API did not return a HTTP 200 (OK) response. Response Code: {0}, Response Text: {1}".format(status_code, response_text))
        exit()

def main():
    update_remote_rules_file()

if __name__ == '__main__':
    main()