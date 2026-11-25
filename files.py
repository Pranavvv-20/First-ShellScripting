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
