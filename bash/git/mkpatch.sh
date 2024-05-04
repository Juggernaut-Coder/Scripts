#!/bin/sh

err() {
        echo "Usage: $0 or $0 -l number_of_commits_to_display"
        exit 1
}

mkpatch () {
        local cnum
        if [ $# -eq 2 ]; then
                if [ "$1" = "-l" ] && [ "$2" -gt 0 ]; then
                        git log --oneline --no-renames -n "$2" | nl -s ':' -w 1
                        if [ $? -ne 0 ]; then
                                echo "git log failed, cannot display commits!"
                                exit 1
                        fi
                        read -p "Choose a commit: " cnum
                        cnum=$((cnum-1))
                else
                        err
                fi
        elif [ $# -eq 0 ]; then
                cnum=0
        else
                err
        fi
        commit=$(git rev-parse HEAD~"$cnum")
        outdir="$(git rev-parse --show-toplevel)_patch"
        if [ ! -d "${outdir}" ]; then
                mkdir -p "${outdir}"
        fi

        start_number_file="${outdir}/start_number.txt"
        if [ ! -f "$start_number_file" ]; then
                echo 1 > "$start_number_file"
        fi

        start_number=$(cat "$start_number_file")

        echo $commit
        git format-patch -1 "$commit" -o "$outdir" --diff-algorithm=histogram --numstat --stat --summary --signoff --progress --full-index --dirstat=lines,files --start-number="$start_number"

        if [ $? -ne 0 ]; then
                echo "Patch file creation failed"
                exit 1
        else
                echo "Patch file created"
                start_number=$((start_number+1))
                echo "$start_number" > "$start_number_file"
        fi

}

mkpatch "$@"
