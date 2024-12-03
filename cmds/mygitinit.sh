#!/usr/bin/bash

# Check if an argument is provided
if [ -z "$1" ]; then
    echo "Provide the Language for .gitignore"
    exit 1
fi

# Check if the "gitignore" folder exists in the home directory
if [ ! -d "$HOME/gitignore" ]; then
    echo "The 'gitignore' folder does not exist in the home directory."
    echo "Cloning the repository..."

    # Clone the repository into the home directory
    git clone https://github.com/Sahma61/gitignore.git "$HOME/gitignore"

    # Check if the cloning was successful
    if [ $? -ne 0 ]; then
        echo "Failed to clone the repository. Exiting."
        exit 1
    fi

    echo "Repository cloned successfully."
else
    echo "The 'gitignore' folder already exists in the home directory."
fi

# Save the current working directory
cwd="$(pwd)"

# Find the required file
required_file="$(find "$HOME/gitignore" -name "*${1}*" -type f)"

# Copy the file to the current directory as .gitignore
if [ -n "$required_file" ]; then
    cp "$required_file" ./.gitignore
    echo "Copied '$required_file' to ./.gitignore"
else
    echo "File not found: *${1}*"
    exit 1
fi

# Initialize a Git repository
if git init; then
    echo "Git repository initialized successfully."
else
    echo "Failed to initialize Git repository. Exiting."
    exit 1
fi
