#!/bin/bash

# Variables for settings
TOOL_DIR="./repo_tools"       # Directory to save tool-related files
DEFAULT_FILE=".gitkeep"       # Default file to add to directories

# Ensure the TOOL_DIR exists
mkdir -p "$TOOL_DIR"

# Function to add a specified file to all directories
add_file() {
    local file=$1
    echo "Adding $file to all directories..."

    find . -type d ! -path "$TOOL_DIR/*" | while read -r dir; do
        touch "$dir/$file"
        echo "Added $file to $dir"
    done
}

# Function to remove a specified file from all directories
remove_file() {
    local file=$1
    echo "Removing $file from all directories..."

    find . -type d ! -path "$TOOL_DIR/*" | while read -r dir; do
        if [ -e "$dir/$file" ]; then
            rm "$dir/$file"
            echo "Removed $file from $dir"
        fi
    done
}

# Save the script itself in the TOOL_DIR for easy access
cp "$0" "$TOOL_DIR/manage_directories.sh"
echo "Saved script to $TOOL_DIR/manage_directories.sh"

# Check command-line arguments
if [ "$1" == "add" ]; then
    add_file "${2:-$DEFAULT_FILE}"
elif [ "$1" == "remove" ]; then
    remove_file "${2:-$DEFAULT_FILE}"
else
    echo "Usage: $0 add|remove [filename]"
    echo "Example: $0 add .gitkeep"
fi

