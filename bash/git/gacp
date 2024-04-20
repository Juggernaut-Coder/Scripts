#!/bin/sh

gacp () {
        if [ ! -d .git ]; then
                echo "Not inside a Git repository."
                exit 1
        fi

        if [ -z "$1" ]; then
                git add .
        else
                git add "$1"
        fi

        if git diff-index --quiet HEAD --; then
                echo "No changes to commit."
                exit 0
        fi

        git commit
        if [ $? -ne 0 ]; then
                echo "Commit failed"
                exit 1
        fi

        git push origin "$(git rev-parse --abbrev-ref HEAD)"
        if [ $? -ne 0 ]; then
                echo "Push failed"
                exit 1
        fi
}

gacp
