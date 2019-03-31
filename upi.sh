#!/bin/bash

# FUNCTIONS

checkGitInstall()
{
    git --version 2>&1 >/dev/null
    echo $?
}

checkGitLFSInstall()
{
    local lfs_state=git lfs env
    if [ $lfs_state="git-lfs*" ]; then
        echo 0
    else
        echo 1
    fi
}

checkAnswer()
{
    if [ $1 = 'y' ] || [ $1 = 'yes' ]; then
        echo 0
    else
        echo 1
    fi
}

# PROGRAM

# Path to project
echo "Type the path to your Unity project, or let empty if you're already in the project folder:"
read -e -p '' project_path

if [ -z $project_path ]; then
    project_path='./'
fi

# Ensure the given path leads to a Unity project by checking if "Assets" folder exists
if [ -e $project_path/Assets ]; then
    echo
else
    echo 'No "Assets" folder found in the given path: this is not a Unity project!'
    exit 3;
fi

# Check Git installation
echo 'Checking Git installation...'

if [ $(checkGitInstall) -eq 0 ]; then
    echo 'Git install OK'
else
    echo 'Please install Git before using Unity Project Initializer. (https://git-scm.com)'
    exit 1
fi

# Git LFS option
echo 'Enable Git LFS (Large File Storage)? (y/n):'
read enable_lfs

# If user wants to use Git LFS
if [ -n "$enable_lfs" ] && [ $(checkAnswer $enable_lfs) -eq 0 ]; then
    echo 'Checking Git LFS installation...'
    # Checks if the command line responds
    if [ $(checkGitLFSInstall) -eq 0 ]; then
        echo 'Git LFS install OK'
    else
        echo 'Please install Git LFS before using Unity Project Initializer. (https://git-lfs.github.com)'
        exit 2
    fi
else
    echo 'Skip Git LFS setup'
fi

# Git remote origin
echo 'Enter the remote origin URL (the URL to your online Git repository), or let empty if you want a local repository:'
read remote_origin_url

# Commit message
default_commit_message='Init project'
echo "Type the message of the first commit (default is $default_commit_message):"
read commit_message

# If the commit message is empty
if [ -z "$commit_message" ]; then
    commit_message=$default_commit_message
fi

# Initialize the project

echo "Ok, let's go!"

unity_project_initializer_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

git init "$project_path"
cp "$unity_project_initializer_path"/.gitignore "$project_path"/.gitignore
touch "$project_path"/Assets/donotdelete.txt

# If user wants to use LFS
if [ -n "$enable_lfs" ] && [ $(checkAnswer $enable_lfs) -eq 0 ]; then
    cp "$unity_project_initializer_path"/.gitattributes "$project_path"/.gitattributes
    cd "$project_path"
    git lfs install
else
    cd "$project_path"
fi

git add .
git commit -m "$default_commit_message"

if [ -n "$remote_origin_url" ]; then
    git remote add origin $remote_origin_url
    git push -u origin master
fi

echo "Git has been successfully setup for this Unity project! Project path: $project_path"