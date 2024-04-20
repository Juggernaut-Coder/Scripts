#!/bin/sh

gacp () {

        if [ -z "$1" ]; then
                git add .
        else
                git add "$1"
        fi
        if [ $? -ne 0 ]; then
                echo "git add failed"
                exit 1
        fi

        if git diff-index --quiet HEAD --; then
                echo "No changes to commit."
                exit 0
        fi

        git commit
        if [ $? -ne 0 ]; then
                echo "git commit failed"
                exit 1
        fi

        git push origin "$(git rev-parse --abbrev-ref HEAD)"
        if [ $? -ne 0 ]; then
                echo "git push failed"
                exit 1
        fi
}

gacp
