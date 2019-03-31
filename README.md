# Unity Git project initializer

This is a simple bash script to execute for setting up Git in a Unity project.

## How to use

Open a Bash terminal (using Git Bash for example). Execute the *.sh file by typing its path in the terminal:

```bash
~/Desktop/unity-git-project-initializer/upi.sh
```

Now, simply follow the written steps ! ;)

## Requirements

In order to setup Git in a Unity project, you have to:

- Create a Unity project
- Install Git ([https://git-scm.com](https://git-scm.com))
- Install Git LFS (if you want to use *Large File Storage*, [https://git-lfs.github.com](https://git-lfs.github.com))

## Steps

1. Type the path to the Unity project's folder*. If you're already placed in the project's folder, just let this field empty
2. Tell if you want to use LFS (*Large File Storage*) by typing `y` or `yes`. Any other input will be considered as "no"
3. Type the remote URL if you have one. You can let this field empty to initialize a local repository
4. Type your message for the first commit

Then, all is ready !

## What it does for you

* Git repository initialization
* Setup `.gitignore` file for Unity
* Install LFS and its `.gitattributes` file if needed
* Creates a donotdelete.txt file in `/Assets` folder in order to add that folder into version control
* Make the first commit of the project
* Push the project to the remote repository if needed