#!/bin/bash

do_files() {
    echo "Enter group name:"
    read group

    if [ -z "$group" ]; then
        echo "Error: Please enter a group name."
        return
    fi

    if [ -e "$group" ]; then
        echo "Error: '$group' already exists. Choose another group name."
        return
    fi

    if ! mkdir "$group"; then
        echo "Error: could not create folder '$group'."
        return
    fi

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
}

do_calc() {
    echo "Enter first number:"
    read num1

    echo "Enter second number:"
    read num2

    if ! [[ $num1 =~ ^[0-9]+$ && $num2 =~ ^[0-9]+$ ]]; then
        echo "Error: Please enter whole numbers only"
        return
    fi

    echo "Sum: $(expr $num1 + $num2)"
    echo "Difference: $(expr $num1 - $num2)"
    echo "Product: $(expr $num1 \* $num2)"

    if [ "$num2" -eq 0 ]; then
        echo "Cannot divide by zero"
    else
        echo "Quotient: $(expr $num1 / $num2)"
        echo "Remainder: $(expr $num1 % $num2)"
    fi

    if [ "$num1" -gt "$num2" ]; then
        echo "$num1 is larger"
    elif [ "$num2" -gt "$num1" ]; then
        echo "$num2 is larger"
    else
        echo "Both numbers are equal"
    fi

    if [ $(expr $num1 % 2) -eq 0 ]; then
        echo "$num1 is even"
    else
        echo "$num1 is odd"
    fi

    if [ $(expr $num2 % 2) -eq 0 ]; then
        echo "$num2 is even"
    else
        echo "$num2 is odd"
    fi

    a=$num1
    b=$num2

    while [ "$b" -ne 0 ]; do
        remainder=$(expr $a % $b)
        a=$b
        b=$remainder
    done

    echo "GCD: $a"
}

do_loops() {
    echo "Enter a whole number:"
    read n

    case $n in
        ''|*[!0-9]*)
            echo "Error: Please enter a whole number, such as 5."
            return
            ;;
    esac

    echo "Multiplication table from 1 to $n:"

    row=1

    while [ $row -le $n ]
    do
        column=1

        while [ $column -le $n ]
        do
            answer=$(expr $row \* $column)
            echo -n "$answer "
            column=$(expr $column + 1)
        done

        echo
        row=$(expr $row + 1)
    done

    echo "Factorial:"

    if [ $n -gt 10 ]
    then
        echo "$n is more than 10, so the factorial will not be calculated."
    else
        factorial=1
        number=1

        while [ $number -le $n ]
        do
            factorial=$(expr $factorial \* $number)
            number=$(expr $number + 1)
        done

        echo "$n! = $factorial"
    fi

    echo "Prime numbers from 2 to $n:"

    current=2

    while [ $current -le $n ]
    do
        is_prime=1
        divisor=2

        while [ $divisor -lt $current ]
        do
            remainder=$(expr $current % $divisor)

            if [ $remainder -eq 0 ]
            then
                is_prime=0
                break
            fi

            divisor=$(expr $divisor + 1)
        done

        if [ $is_prime -eq 1 ]
        then
            echo -n "$current "
        fi

        current=$(expr $current + 1)
    done

    echo
}

show_log() {
    if [ -f session.log ]; then
        cat session.log
    else
        echo "No session log found."
    fi
}

while true
do
    echo "==== Study Group Toolkit ===="
    echo "1) Create a group folder"
    echo "2) Calculator"
    echo "3) Number tools"
    echo "4) Show session log"
    echo "5) Quit"

    echo "Enter your choice:"
    read choice

    case $choice in
        1)
            echo "Create a group folder selected on $(date)" >> session.log
            do_files
            ;;
        2)
            echo "Calculator selected on $(date)" >> session.log
            do_calc
            ;;
        3)
            echo "Number tools selected on $(date)" >> session.log
            do_loops
            ;;
        4)
            echo "Session log viewed on $(date)" >> session.log
            show_log
            ;;
        5)
            echo "Quit selected on $(date)" >> session.log
            read -r -p "Delete session.log? (y/n) " answer

            if [ "$answer" = "y" ]; then
                rm session.log
                echo "Session log deleted."
            else
                echo "Session log kept."
            fi

            break
            ;;
        *)
            echo "Invalid choice. Please select 1 to 5."
            ;;
    esac

    echo
done
