#!/bin/bash

# --------------------------------------------------
# Copyright 2018 Source Foundry Authors
# MIT License
# Source: https://github.com/source-foundry/alt-hack
# ---------------------------------------------------

# 1. Set the path to the downloaded Hack repo here first
HACK_PATH="/home/user01/alt-hack-wip/Hack"

# 2. List your alternate glyphs here
declare -a alternates=(
    "u0030-forwardslash" # zero with forward slash 
    "u0069-slab" # letter i with slab
)

# 3. Run this script and enjoy!

# ------------------------------------------------------------------------------------------------ #

if [ -z $HACK_PATH ]; then
    echo "❌ Set the HACK_PATH variable in this script to your downloaded Hack repo root."
    exit 1
fi

declare -a styles=("Regular" "Bold" "Italic" "BoldItalic")

for alternate in "${alternates[@]}"
do
    for style in "${styles[@]}"
    do
        stylePath="${HACK_PATH}/source/Hack-${style}.ufo/glyphs"
        lowercaseStyle=$(echo "$style" | tr '[:upper:]' '[:lower:]')
        alternatePath="./glyphs/${alternate}/${lowercaseStyle}"

        if ! cp "$alternatePath"/*.glif "$stylePath"; then
            echo "❌ Aborting patching of Hack, check errors above."
            exit 1
        fi
    done

    echo "✅ Patched $alternate"
done

echo
echo "All done! Now go to the Hack repo and build the font files."
