#!/bin/bash

time=$(date)
echo $time
n=1
echo "============================Auto Git============================"
echo "|| This script is now monitoring this current directory       ||"
echo "|| Enter the update interval between each push (Eg. 1 = 1 min)||"
echo "================================================================"
echo "-------------------"
read -p "Interval Time: " inter
echo "-------------------"
echo 
echo 
echo 
echo 
echo
while :
do 
    if [ -d .git ]; then
        echo "====================================="
        echo "|| This is the current Repo Status ||"
        echo "====================================="
        git add .
        git status
        echo "-----------------------------------------------------------------------------------------"
        
        # Get the list of files changed
        files_changed=$(git diff --name-only --diff-filter=ACM)
        
        # Commit with files changed in the message
        if [ -n "$files_changed" ]; then
            git commit -m "Updated: $files_changed"
        else
            git commit -m "No changes to commit"
        fi
        
        echo "-----------------------------------------------------------------------------------------"
        git push
        echo "--------------------"
        echo "|| Commit $n Made ||"
        echo "--------------------"
        
        n=$(($n + 1));
    else
        echo "==================================="
        echo "|| Fatal! This is Not a Git Repo ||"
        echo "==================================="
        git rev-parse --git-dir 2> /dev/null;
        exit 1;
    fi;
    d=$(($inter * 60));
    sleep $d;
done
