#!/bin/bash

SCRIPT_DIR=$(dirname $(realpath "$BASH_SOURCE"))
OUTPUT_FILE="/tmp/build_alertbuild.sh"

SOURCE_FILE="main.sh"
OUTPUT_FILE="/tmp/build_alertbuild.sh"

touch "$OUTPUT_FILE"

process_file() {
    local file="$1"
    while IFS= read -r line; do
        if [[ "$line" =~ ^source* ]]; then
            source_file=$(echo "$line" | awk '{print $2}')  
            source_file="$SCRIPT_DIR/${source_file#'$SCRIPT_DIR/'}"  
        else
            echo "$line" >> "$OUTPUT_FILE"
            continue
        fi

        if [[ -f "$source_file" ]]; then
            cat "$source_file" >> "$OUTPUT_FILE"
        else
            exit 1
        fi
    done < "$file"
}

process_file "$SCRIPT_DIR/$SOURCE_FILE"

chmod +x "$OUTPUT_FILE"

shc -rvf "$OUTPUT_FILE" -o $SCRIPT_DIR/alertbuild 
sudo mv $SCRIPT_DIR/alertbuild /usr/local/bin

rm "$OUTPUT_FILE"