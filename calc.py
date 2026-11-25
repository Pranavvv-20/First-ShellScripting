# calc.py - asks for two whole numbers and does calculations on them.
# Usage: python calc.py

import re       # regular expressions, for checking the input is digits only
import sys


def calculator():
    """Run the calculator. Returns True if it worked, False on bad input."""

    # input() always gives back TEXT, even if you type 12
    num1 = input("Enter the first number:\n")
    num2 = input("Enter the second number:\n")

    # Check both are whole numbers: [0-9]+ = one or more digits
    if not (re.fullmatch(r"[0-9]+", num1) and re.fullmatch(r"[0-9]+", num2)):
        print("Please enter valid whole numbers")
        return False

    # Turn the text into numbers so we can do maths
    num1 = int(num1)
    num2 = int(num2)

    print(f"Sum: {num1 + num2}")
    print(f"Difference: {num1 - num2}")
    print(f"Product: {num1 * num2}")

    # Check for zero BEFORE dividing
    if num2 == 0:
        print("Division is not possible")
        print("Remainder is not possible")
    else:
        print(f"Quotient: {num1 // num2}")      # // = whole-number division
        print(f"Remainder: {num1 % num2}")      # % = what's left over

    # Compare the numbers
    if num1 > num2:
        print(f"{num1} is greater")
    elif num1 < num2:
        print(f"{num2} is greater")
    else:
        print("Both numbers are equal")

    # Even if the remainder after dividing by 2 is 0
    if num1 % 2 == 0:
        print(f"{num1} is even")
    else:
        print(f"{num1} is odd")

    if num2 % 2 == 0:
        print(f"{num2} is even")
    else:
        print(f"{num2} is odd")

    # GCD (Euclid's algorithm): keep doing (a, b) -> (b, a % b) until b is 0
    a = num1
    b = num2
    while b != 0:
        a, b = b, a % b
    print(f"GCD: {a}")

    return True


# Only runs when you run this file directly
if __name__ == "__main__":
    if not calculator():
        sys.exit(1)
