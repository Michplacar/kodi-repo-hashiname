#!/usr/bin/env bash

for d in $(find . -type d -type l -or -depth 1); do
    addon_xml="$d/addon.xml"
    if [ -f "$d/addon.xml" ]; then
        vers=$(cat $addon_xml | grep -v '\<xml\>.*version' | grep 'version' | head -n1 | sed -re 's/^.*version\s*=\s*\"([^\""]+)\".*$/\1/')
        mkdir -p "datadir/$d"
        rm -f "datadir/$d/$d-$vers.zip"
        zip -r --exclude=*.git* --exclude=*.DS_Store* --exclude=*/test/* "datadir/$d/$d-$vers.zip" "$d"
    fi
done

python addons_xml_generator.py
