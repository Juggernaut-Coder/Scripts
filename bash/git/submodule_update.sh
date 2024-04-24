#At the moment hard coded with example
submodule_add() {
    git submodule add "https://github.com/example/submodule.git submodules/submodule_name"
    cd submodules/submodule_name
    git submodule init
    submodule_update
}


get_latest_release_tag() {
    repo_url="https://api.github.com/repos/smasherprog/screen_capture_lite/releases/latest"
    latest_tag=$(curl -sSL "$repo_url" | jq -r '.tag_name')
    if [ $? -eq 0 ]; then 
        echo "$latest_tag"
    else
        #echo "Error: Failed to get latest tag" >&2
        exit 1
    fi
}

submodule_update() {
    latest_tag=$(get_latest_release_tag)
    cd screen_capture_lite
    current_tag=$(git describe --tags --abbrev=0)
    if [ "$current_tag" != "$latest_tag" ]; then
        git switch --detach "$latest_tag"
        git submodule update --checkout .
        if [ $? -eq 0 ]; then
            git add .
            git commit -m "Switched submodule screen_capture_lite to $latest_tag and updated files"
            #echo "submodule screen_capture_lite updated"
        else 
            #echo "Error: Failed to update submodule"
        fi
    else 
        #echo "submodule already up to date"
    fi
}

#read -p "Press Enter to exit..."
