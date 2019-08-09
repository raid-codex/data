import os
import json

data = []
with open(os.getenv("GOPATH")+"/src/github.com/raid-codex/data/docs/champions/current/index.json") as f:
    x = json.load(f)
    for champion in x:
        new_data = {
            "name": champion.get("name"),
            "element": champion.get("element"),
            "type": champion.get("type"),
            "rarity": champion.get("rarity"),
            "faction_slug": champion.get("faction_slug"),
            "rating": {
                "overall": champion.get("rating", {}).get("overall"),
            },
            "thumbnail": champion.get("thumbnail"),
            "website_link": champion.get("website_link"),
            "skills": [],
            "tags": champion.get("tags", []),
        }
        for skill in champion.get("skills"):
            s = {
                "effects": [{
                    "slug": effect.get("slug"),
                } for effect in skill.get("effects")],
                "upgrades": [{
                    "effects": [{
                        "slug": effect.get("slug"),
                    } for effect in upgrade.get("effects")],
                } for upgrade in skill.get("upgrades")]
            }
            new_data.get("skills").append(s)
        data.append(new_data)
with open(os.getenv("GOPATH")+"/src/github.com/raid-codex/data/docs/champions/index-small.json", "w") as f2:
    f2.write(json.dumps(data))
