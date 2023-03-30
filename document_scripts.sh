#!/bin/bash
# Create an automated documentation for all scripts in the current directory
# Produces this documentation.

# Remove the README.md file if it already exists
rm -f README.md

# Loop over all script files in the current directory
for file in [!.]*; do
    # Extract the script name from the filename
    script_name="${file%.*}"

    # Extract all lines at the beginning of the script that start with "#"
    script_description=$(awk '/^#/ {if (NR>1) print ""; printf("%s", $0); next} /^\s*$/{exit}' "$file" | tail -n +2 | sed 's/^# //')

    # Create the markdown documentation for the script
    documentation="## $script_name\n\n$script_description\n\n"

    # Save the documentation to a markdown file with the same name as the script
    echo -e "$documentation" >> "README.md"
done

# Create the header for the README.md file
echo -e "# home/bin\nA repository to hold my custom shell scripts.\n" | cat - README.md > temp && mv temp README.md