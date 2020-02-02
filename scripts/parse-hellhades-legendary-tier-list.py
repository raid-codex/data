import sys, csv, os

r = csv.reader(sys.stdin)
for row in r:
	data = {
		"name": row[1],
		"rating": {
			"clan_boss": row[4],
			"arena": row[5],
			"dragon": row[6],
			"fire_knight": row[7],
			"ice_golem": row[8],
			"spider": row[9],
			"campaign": row[10]
		}
	}
	cmd = "raid-codex-cli champions rating add-from-source --data-directory . --champion-name \""+data['name']+"\" --source hellhades-tier-list --weight 5 --clan-boss "+data['rating']['clan_boss']+" --arena "+data['rating']['arena']+" --dragon "+data['rating']['dragon']+" --fire-knight "+data['rating']['fire_knight']+" --ice-golem "+data['rating']['ice_golem']+" --spider "+data['rating']['spider']+ " --campaign "+data['rating']['campaign']
	os.system(cmd)
