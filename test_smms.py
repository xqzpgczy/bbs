import requests, json, base64

URL = "https://sm.ms/api/v2"
Token = "ZxOOme2RDVqo42qwYqjPJkxSy08zyqvc"
FilePath = "/Users/dingjinlong/Downloads/a.png"


def upload(path):
    headers = {'Authorization': Token}
    files = {'smfile': open(path, 'rb')}
    url = 'https://sm.ms/api/v2/upload'
    res = requests.post(url, files=files, headers=headers).json()
    print(json.dumps(res, indent=4))

upload(FilePath)