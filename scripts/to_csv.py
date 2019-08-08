import os
import json
import csv

with open(os.getenv("GOPATH")+"/src/github.com/raid-codex/data/docs/champions/current/index.json") as f:
    x = json.load(f)
    data = []
    for champion in x:
        for skill in champion.get("skills"):
            base_data = {
                "champion_name": champion.get("name"),
                "skill_name": skill.get("name"),
                "skill_description": skill.get("raw_description"),
            }
            data.append(base_data)

    with open(os.getenv("GOPATH")+"/src/github.com/raid-codex/data/csv/champions-skills.csv", "w") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=data[0].keys())
        writer.writeheader()
        for d in data:
            writer.writerow(d)