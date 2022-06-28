#!/usr/bin/env python

import requests
import json

root_url = 'http://169.254.169.254/latest/'

def fetch_metadata(url, path):
    result = {}
    for item in path:
        new_url = url + item
        raw_data = requests.get(new_url).text
        if item[-1] == "/":
            values = raw_data.splitlines()
            result[item[:-1]] = fetch_metadata(new_url, values)
        elif is_json(raw_data):
            result[item] = json.loads(raw_data)
        else:
            result[item] = raw_data
    return result

def is_json(myjson):
    try:
        json.loads(myjson)
    except ValueError:
        return False
    return True

def fetch_metadata_json():
    context = ["meta-data/"]
    metadata = fetch_metadata(root_url, context)
    metadata_json = json.dumps(metadata, indent=4, sort_keys=True)
    return metadata_json

if __name__ == '__main__':
    print(fetch_metadata_json())