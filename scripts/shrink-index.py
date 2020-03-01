import os
import json

data = []
dir = os.getenv("DIRECTORY")
if dir is None:
    dir = os.getenv("GOPATH")
    if not dir:
        raise NotImplementedError("No GOPATH and no DIRECTORY env var")
    dir += "/src/github.com/raid-codex/data"

with open(dir+"/docs/champions/current/index.json") as f:
    x = json.load(f)
    for champion in x:
        new_data = {
            "slug": champion.get("slug"),
            "name": champion.get("name"),
            "element": champion.get("element"),
            "type": champion.get("type"),
            "rarity": champion.get("rarity"),
            "faction_slug": champion.get("faction_slug"),
            "rating": champion.get("rating"),
            "thumbnail": champion.get("thumbnail"),
            "website_link": champion.get("website_link"),
            "skills": [],
            "auras": [],
            "tags": champion.get("tags", []),
        }
        for skill in champion.get("skills", []):
            eff1 = [effect.get("slug") for effect in skill.get("effects", [])]
            eff2 = [effect.get("slug")
                    for upgrade in skill.get("upgrades", [])
                    for effect in upgrade.get("effects", [])]
            effects = set(eff1 + eff2)
            s = {
                "effects": [{
                    "slug": effect,
                } for effect in effects],
            }
            new_data.get("skills").append(s)
        for aura in champion.get("auras"):
            a = {
                "stats": aura.get("stats"),
                "locations": aura.get("locations"),
            }
            new_data.get("auras").append(a)
        data.append(new_data)
with open(os.getenv("GOPATH")+"/src/github.com/raid-codex/data/docs/champions/index-small.json", "w") as f2:
    f2.write(json.dumps(data, separators=(',', ':')))
