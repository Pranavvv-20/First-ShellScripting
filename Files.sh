#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: files.sh <group_name>"
    exit 1
fi

group="$1"

if [ -e "$group" ]; then
    echo "Error: '$group' already exists. Choose another group name."
    exit 1
fi

mkdir "$group"

members="$group/members.txt"
backup="$group/members_backup.txt"
log="$group/log.txt"

touch "$members"

echo "Enter member names one at a time. Type 'done' when finished."

while read -r -p "Name: " name; do
    if [ "$name" = "done" ]; then
        break
    fi
    if [ -z "$name" ]; then
        echo "Empty name ignored."
        continue
    fi
    echo "$name" >> "$members"
done

echo "--- Members ---"
cat "$members"

count=$(wc -l < "$members")
echo "Number of members: $count"

cp "$members" "$backup"

if [ -f "$members" ] && [ -f "$backup" ]; then
    echo "Both members.txt and members_backup.txt exist."
else
    echo "Error: one of the member files is missing."
fi

echo "--- Contents of $group ---"
ls -l "$group"

echo "Created on $(date)" >> "$log"

read -r -p "Delete everything? (y/n) " answer

if [ "$answer" = "y" ]; then
    rm -f "$members" "$backup" "$log"
    rmdir "$group"
    echo "Deleted '$group' and its files."
else
    echo "Folder kept at: $(cd "$group" && pwd)"
fi
