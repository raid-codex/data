#!/bin/bash
set -e

if [[ $# -ne 2 ]]
then
    echo "Usage: $0 champion_name directory_for_images"
    exit 1
fi

name=$1
dir=$2

slug=$(python -c "import sys; sys.stdout.write('${name}'.lower().replace('\'', '-').replace(' ', '-'))")
image_name=$(python -c "import sys; sys.stdout.write('${name}'.replace('-', '_').replace(' ', '_'))")

# generate giid
giid=$(python -c "import sys; sys.stdout.write(''.join(['{}'.format(ord(c)) for c in '${name}']))")

echo "Champion: ${name} ; image_name: ${image_name} ; slug: ${slug}"
echo "GIID: $giid"

filename="${giid}"
cp "$GOPATH/src/github.com/McRadane/raid-data/images/avatar/${image_name}.png" "$dir/${filename}.png"
cp "$GOPATH/src/github.com/McRadane/raid-data/images/Skills/${image_name}_s1.png" "$dir/${filename}_s1.png" || true
cp "$GOPATH/src/github.com/McRadane/raid-data/images/Skills/${image_name}_s2.png" "$dir/${filename}_s2.png" || true
cp "$GOPATH/src/github.com/McRadane/raid-data/images/Skills/${image_name}_s3.png" "$dir/${filename}_s3.png" || true
cp "$GOPATH/src/github.com/McRadane/raid-data/images/Skills/${image_name}_s4.png" "$dir/${filename}_s4.png" || true
cp "$GOPATH/src/github.com/McRadane/raid-data/images/Skills/${image_name}_s5.png" "$dir/${filename}_s5.png" || true
bash ../tools/set-giid.sh "$name" "$giid"
bash scripts/refresh_champion.sh "$slug"