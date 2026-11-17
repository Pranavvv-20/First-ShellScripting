#!/bin/bash

echo "Enter a whole number:"
read n

case $n in
    ''|*[!0-9]*)
    echo "Error: Please enter a whole number, such as 5."
    exit 1
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
