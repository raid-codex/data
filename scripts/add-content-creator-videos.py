#!/usr/bin/env python3

import os
import json
import sys
from os.path import isfile, join

gopath = os.getenv("GOPATH")
data_directory = os.getenv("DATA_DIRECTORY",
                           f"{gopath}/src/github.com/raid-codex/data")
content_creator_directory = os.getenv("CONTENT_CREATOR_DIRECTORY",
                                      f"{gopath}/src/github.com/raid-codex/content-creators")

path = f"{content_creator_directory}/docs"
for filename in os.listdir(path):
    filepath = join(path, filename)
    if not isfile(filepath):
        continue
    with open(filepath) as file:
        creator = json.load(file)
        for video in creator['youtube']['videos']:
            if "champion_guide" in video:
                os.system(f"""
                    raid-codex-cli champions video add --source youtube --author {creator['name']} --video-id {video['id']} --data-directory {data_directory} --champion-slug {video['champion_guide']['champion_slug']}
                """)
