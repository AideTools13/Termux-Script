#!/bin/bash
# Shell Script to add all files, commit them with a commit message from user and then push them to remote GitHub repo
#Bashcolor
blue='\e[1;34m' 
green='\e[1;32m' 
purple='\e[1;35m' 
cyan='\e[1;36m' 
red='\e[1;31m' 
white='\e[1;37m' 
echo -e $green "*** Automating Git Add, Commit and Push ***"

#Ask for Username
echo -e $green "Enter your GitHub username: "
read username

#Ask for User Github's personal access token
echo -e $green "Enter your GitHub personal access token: "
read token

# Ask for repository name
echo -e $green "Enter repository name"
read repoName
# Check if repository exists at GitHub
curl "https://api.github.com/repos/${username}/${repoName}"
# If repository exits then
if [ $? -eq 0 ]; then
    # Ask for local storage
    echo -e $green "Enter local storage name"
    read local_storage
    cd $local_storage
    # Display unstaged files
    git status
    git remote set-url origin https://${token}@github.com/${username}/${repoName}.git
    # If there are any uncommited and unstatged files, ask user to commit them
    if [ "$(git status --porcelain)" ]; then
        # Add File For Push
        echo -e $green "Add File For Push"
        read file_for_push
        git add $file_for_push
        echo -e $green "There are uncommited and unstatged files. Commit them before pushing"
        echo -e $green "Enter commit message"
        read commitMessage
        
        git commit -m "$commitMessage"
        git push -u origin main
        echo -e $green "Files pushed to GitHub"
        # else push all commited and staged files to remote repo
    else
        git push -u origin main
        echo -e $green "Files pushed to GitHub"
        
    fi
    #Echo message if there is no files to commit, stage or push
    if [ "$(git status --porcelain)" ]; then
        echo -e $green "There are no files to commit, stage or push"
    fi
else
    echo -e $green "Repository does not exist"
fi


# End of script
