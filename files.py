# files.py - sets up a folder for a study group.
# Usage: python files.py <group_name>

import os           # tools for files and folders
import sys          # command-line arguments (sys.argv) and sys.exit
import shutil       # copying files
from datetime import datetime   # for the date in the log


def create_group(group):
    """Create the group folder, collect member names and save them.
    Returns True if it worked, False if there was an error."""

    # Stop if a file or folder with this name already exists
    if os.path.exists(group):
        print(f"Error: '{group}' already exists. Choose another group name.")
        return False

    os.mkdir(group)         # create the folder

    # Build the file paths (os.path.join uses the right slash for Windows/Mac)
    members = os.path.join(group, "members.txt")
    backup = os.path.join(group, "members_backup.txt")
    log = os.path.join(group, "log.txt")

    # Create an empty members file ("w" = write mode creates the file)
    with open(members, "w"):
        pass                # do nothing, opening it was enough

    print("Enter member names one at a time. Type 'done' when finished.")

    # Keep asking for names until the user types done
    while True:
        try:
            name = input("Name: ")      # show a prompt and read what's typed
        except EOFError:                # input ran out (Ctrl+Z then Enter on Windows)
            break

        if name == "done":
            break                       # leave the loop
        if name == "":
            print("Empty name ignored.")
            continue                    # skip to the next name
        # "a" = append mode: adds to the end of the file
        with open(members, "a") as f:
            f.write(name + "\n")        # \n = new line after each name

    # Read the names back and print them
    print("--- Members ---")
    with open(members) as f:
        names = f.read().splitlines()   # list of lines, e.g. ["Pranav", "Sam"]
    for n in names:
        print(n)

    count = len(names)                  # number of items in the list
    print(f"Number of members: {count}")

    shutil.copy(members, backup)        # make a backup copy

    # Check that both files exist
    if os.path.isfile(members) and os.path.isfile(backup):
        print("Both members.txt and members_backup.txt exist.")
    else:
        print("Error: one of the member files is missing.")

    # Show what's in the folder, with each file's size
    print(f"--- Contents of {group} ---")
    for filename in sorted(os.listdir(group)):
        size = os.path.getsize(os.path.join(group, filename))
        print(f"{size:>6} bytes  {filename}")

    # Add the date to the log file
    with open(log, "a") as f:
        f.write(f"Created on {datetime.now().strftime('%a %b %d %H:%M:%S %Y')}\n")

    answer = input("Delete everything? (y/n) ")

    if answer == "y":
        for path in (members, backup, log):
            if os.path.exists(path):
                os.remove(path)         # delete each file
        os.rmdir(group)                 # delete the folder (must be empty)
        print(f"Deleted '{group}' and its files.")
    else:
        print(f"Folder kept at: {os.path.abspath(group)}")

    return True


# Only runs when you run this file directly, not when menu.py imports it
if __name__ == "__main__":
    # sys.argv = ["files.py", "mygroup"], so sys.argv[1] is the group name
    if len(sys.argv) < 2:
        print("Usage: files.py <group_name>")
        sys.exit(1)

    if not create_group(sys.argv[1]):
        sys.exit(1)
