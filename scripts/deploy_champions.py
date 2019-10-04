#!/usr/bin/env python3

import ftplib
import os

base_dir = "{}/src/github.com/raid-codex/data/generated/champions/".format(
    os.getenv("GOPATH"),
)


def upload_file(filename, full_path, ftp):
    target = "www/generated/champions/{}".format(filename)
    print("should override {} with content".format(target))
    with open(full_path) as f:
        ftp.storbinary("STOR {}".format(target),
                       content)
        print("ok")


with ftplib.FTP(host=os.getenv("FTP_HOST"),
                user=os.getenv("FTP_USER"),
                passwd=os.getenv("FTP_PASSWORD")) as ftp:
    print("Logged in")
    for (_, _, filenames) in os.walk(base_dir):
        for filename in filenames:
            upload_file(filename=filename,
                        full_path="{}{}".format(base_dir, filename),
                        ftp=ftp)
