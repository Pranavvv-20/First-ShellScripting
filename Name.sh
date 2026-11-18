#!/bin/bash

file="todo.txt"

> "$file"

read -r -p "What's your name? " name
echo "Hi $name! Type your tasks one at a time. Type 'done' when finished."

while read -r -p "Task: " task; do
    if [ "$task" = "done" ]; then
        break
    fi
    if [ -z "$task" ]; then
        continue
    fi
    echo "$task" >> "$file"
done

echo "--- $name's to-do list ---"
cat -n "$file"

count=$(wc -l < "$file")
echo "You have $count tasks. Good luck!"
