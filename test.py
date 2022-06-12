import requests, json, base64
from requests_toolbelt.multipart.encoder import MultipartEncoder

URL = "https://www.pandaimg.com/api/v1"

FilePath = "/Users/dingjinlong/Downloads/b.png"

def get_token():
    url = URL + "/tokens"
    heards = {"Accept": "application/json"}

    data = {"email":"625124155@qq.com", "password": "625124155"
    }
    # data = json.dumps(data)
    print(url)
    resp = requests.post(url, data=data, headers=heards)
    r = resp.content
    r = json.loads(r)
    return r["data"]["token"]

# token = get_token()

Token = "Bearer " + "8|mepaEvWfYpMMhfDtfKH1IWln2Y05WgTzLMzNYaUM"



def get_user():
    url = URL + "/profile"
    heards = {"Accept": "application/json", "Authorization":Token}

    resp = requests.get(url=url, headers=heards)
    print(resp.content)


# get_user()


def upload(path):
    h = {"Accept": "application/json", "Authorization":Token,  "Content-Type": "multipart/form-data"}
    url = URL + "/upload"

    fl = open(FilePath, "rb")

    multipart_encoder = MultipartEncoder(
        fields={
            "file": ("2.jpg", fl, "image/jpg")
        },
        boundary='----WebKitFormBoundaryJ2aGzfsg35YqeT7X'
    )
    h['Content-Type'] = multipart_encoder.content_type

    print(multipart_encoder)
    # res = requests.post(url, data=multipart_encoder, headers=h)
    # r = res.content
    # print(json.loads(r))

upload(FilePath)


def upload2(path):
    h = {"Accept": "application/json", "Authorization":Token,  "Content-Type": "multipart/form-data"}
    url = URL + "/upload"

    # file = {'file': open(path, 'rb')}
    file = ("1.png", open(path, "rb"), "image/png")

    data = {"file": file}

    print(data)
    res = requests.post(url, files = data, headers=h)
    r = res.content
    print(json.loads(r))


upload2(FilePath)