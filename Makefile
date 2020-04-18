
sanitize_champions:
	@bash scripts/sanitize.sh champions

rebuild_index_champions:
	@bash scripts/rebuild_index.sh champions

sanitize_factions:
	@bash scripts/sanitize.sh factions

rebuild_index_factions:
	@bash scripts/rebuild_index.sh factions

sanitize_status_effects:
	@bash scripts/sanitize.sh status-effects

rebuild_index_status_effects:
	@bash scripts/rebuild_index.sh status-effects

sanitize_fusions:
	@bash scripts/sanitize.sh fusions

rebuild_index_fusions:
	@bash scripts/rebuild_index.sh fusions

content_creator_videos:
	@python3 scripts/add-content-creator-videos.py
	@make rebuild_index_champions

all:
	make sanitize_champions 
	make rebuild_index_champions 
	make sanitize_factions 
	make rebuild_index_factions 
	make sanitize_status_effects 
	make rebuild_index_status_effects 
	make sanitize_fusions 
	make rebuild_index_fusions 
	make sanitize_champions 
	make rebuild_index_champions