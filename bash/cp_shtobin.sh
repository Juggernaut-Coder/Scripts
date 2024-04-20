#!/bin/sh

cp_sh_to_bin () {
        if [ $# -ne 1 ]; then
                echo "Usage: $0 folder_location"
                exit 1
        fi

        if [ ! -d ~/.local/bin ]; then
                mkdir -p ~/.local/bin
        fi

        for file in "$1"/*.sh; do
                if [ -f "$file" ]; then
                        fname=$(basename "$file" .sh)
                        cp "$file" ~/.local/bin/"$fname"
                        chmod +x ~/.local/bin/"$filename"
                fi
        done
        echo "All *.sh files copied to ~/.local/bin"
}

cp_sh_to_bin "$@"
