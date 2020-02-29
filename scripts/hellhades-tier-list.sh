#!/bin/bash
set -e

wget "https://docs.google.com/spreadsheets/d/1YjETkvBMVKZr7CPDjL_iIy_Wa6-psHob6so6fgKLX7c/gviz/tq?tqx=out:csv&sheet=Legendaries" -O /tmp/legendaries.csv
wget "https://docs.google.com/spreadsheets/d/1YjETkvBMVKZr7CPDjL_iIy_Wa6-psHob6so6fgKLX7c/gviz/tq?tqx=out:csv&sheet=Epics" -O /tmp/epics.csv
wget "https://docs.google.com/spreadsheets/d/1YjETkvBMVKZr7CPDjL_iIy_Wa6-psHob6so6fgKLX7c/gviz/tq?tqx=out:csv&sheet=Rares" -O /tmp/rares.csv
raid-codex-cli champions parse tier-list-hellhades --data-directory . --csv-file /tmp/legendaries.csv
raid-codex-cli champions parse tier-list-hellhades --data-directory . --csv-file /tmp/epics.csv
raid-codex-cli champions parse tier-list-hellhades --data-directory . --csv-file /tmp/rares.csv
make sanitize_champions
make rebuild_index_champions