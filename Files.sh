#!/bin/bash

echo "Enter the first number:"
read num1

echo "Enter the second number:"
read num2

if ! [[ $num1 =~ ^[0-9]+$ && $num2 =~ ^[0-9]+$ ]]; then
    echo "Please enter valid whole numbers"
    exit 1
fi

echo "Sum: $(expr $num1 + $num2)"
echo "Difference: $(expr $num1 - $num2)"
echo "Product: $(expr $num1 \* $num2)"

if [ "$num2" -eq 0 ]; then
    echo "Division is not possible"
    echo "Remainder is not possible"
else
    echo "Quotient: $(expr $num1 / $num2)"
    echo "Remainder: $(expr $num1 % $num2)"
fi

if [ "$num1" -gt "$num2" ]; then
    echo "$num1 is greater"
elif [ "$num1" -lt "$num2" ]; then
    echo "$num2 is greater"
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
