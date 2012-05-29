#!/usr/bin/env sh

## Copyright 2012 Daniel Bolton
## https://github.com/dbb/zeshin
## Distributed under the GNU GPL

## vars ###################################################################
cmd=$1
timestamp=$( date +%s )

## file list, realtive to ~
files=".zshrc .zshenv"
## Github user name (probably fine as is)
ghuser=$( git config github.user )
## name of the repository on Github
repo_name='myzeshin'
## where the local copy of the repo is kept
zeshin_dir="${HOME}/src"

## make hard backups; only necessary for the truly paranoid
backup=0
backup_dir="${HOME}/.zeshin"

## end vars ###############################################################


if [ ! -d $backup_dir ]; then
    mkdir -p $backup_dir
fi

if [ $backup = 1 ]; then
    cp -r ${HOME}/${i} $backup_dir/${i}_${timestamp}
fi

if [ ! -d $zeshin_dir ]; then
    mkdir -p $zeshin_dir
fi


case $cmd in
    init)
        cd $zeshin_dir

        curl -F login=${ghuser} -F token=$( git config github.token ) \
            https://github.com/api/v2/yaml/repos/create -F name=${repo_name}

        if [ ! -d $repo_name ]; then
            mkdir ${repo_name}
        fi

        cd $repo_name
        git init
        echo '*~'"\n*.swp" >> .gitignore

        for i in $files; do
            print "Copying ~/$i to repo"
            cp -r ${HOME}/${i} .
            git add $i
            git commit -m "Adding $i"
        done
        git remote add origin git@github.com:${ghuser}/${repo_name}.git
        git push -u origin master
    ;;

    dl)
        cd ${zeshin_dir}/${repo_name}

        if [ -d .git ]; then
            git pull
        else
            git clone git@github.com:${gh_user}/${repo_name}.git
        fi

        for i in $files; do
            echo "Installing $i to ~\n"
            cp -r $i ~
        done
    ;;

    ul)
        cd ${zeshin_dir}/${repo_name}
        for i in $files; do
            echo "Uploading $i\n"
            cp -r ~/${i} .
            git add $i
            git commit -m "Update $i"
        done

        git push -u origin master

esac
