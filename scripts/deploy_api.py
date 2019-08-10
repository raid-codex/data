#!/usr/bin/env python3

import ftplib
import os
import json
import io

base_dir = "{}/src/github.com/raid-codex/data/docs/champions/current/".format(
    os.getenv("GOPATH"),
)


def upload_file(filename, full_path, ftp):
    content = None
    with open(full_path) as f:
        content = json.load(f)
    content = io.BytesIO(json.dumps(content,
                                    separators=(',', ":")).encode("utf-8"))
    print("should override api/champions/.data/{} with content".format(filename))
    ftp.storbinary("STOR api/champions/.data/{}".format(filename),
                   content)
    print("ok")


with ftplib.FTP(host=os.getenv("FTP_HOST"),
                user=os.getenv("FTP_USER"),
                passwd=os.getenv("FTP_PASSWORD")) as ftp:
    print("Logged in")
    upload_file(filename="index-small.json",
                full_path="{}/../index-small.json".format(base_dir),
                ftp=ftp)
    for (_, _, filenames) in os.walk(base_dir):
        for filename in filenames:
            upload_file(filename=filename,
                        full_path="{}{}".format(base_dir, filename),
                        ftp=ftp)
