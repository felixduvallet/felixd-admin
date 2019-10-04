#!/usr/bin/env bash

# Adapted from https://github.com/not-an-aardvark/git-delete-squashed (under
# MIT license).

set -e

do_delete=0
delete_all=0

usage() { echo "Usage: $0 [-a](all) [-d](delete).\nDry-run is default." 1>&2; exit 1; }

while getopts ':ad' flag; do
    case "${flag}" in
        a) delete_all=1 ;;
        d) do_delete=1 ;;
        *) usage ;;
    esac
done

if [[ $do_delete -ne 1 ]]; then
    printf "\n\n\tDRY RUN ONLY!\n\n\n"
fi

git checkout -q master
for branch in $(git for-each-ref refs/remotes/origin "--format=%(refname:short)"); do
    # Skip branches containing HEAD, master.
    if [[ "$branch" == *"master"* || "$branch" == *"candidate"* || "$branch" == *"stable"* || "$branch" == *"HEAD"* ]]; then
        continue
    fi

    # Commit at which this branch was created.
    merge_base=$(git merge-base master $branch)
    tmp_commit=$(git commit-tree $(git rev-parse $branch^{tree}) -p $merge_base -m _)
    if [[ $(git cherry master $tmp_commit) == "-"* ]]; then

        # Convert origin/branch_name to branch_name.
        short_branch=$(echo $branch | sed 's/^origin\///')

        # Print some information about it.
        creation_date=$(git log --pretty=format:"%ad" --date=short -n 1 ${merge_base})
        branch_age=$(git log --pretty=format:"%cr" --date=short -n 1 ${merge_base})
        last_update=$(git log --pretty=format:"%ad" --date=short -n 1 ${branch})
        update_age=$(git log --pretty=format:"%cr" --date=short -n 1 ${branch})
        commit_message=$(git log --pretty=format:'%s' -n 1 ${branch})
        printf "Branch name     : ${short_branch}\n"
        printf "Created on      : ${creation_date} (${branch_age})\n"
        printf "Last updated on : ${last_update} (${update_age})\n"
        printf "Commit message  : ${commit_message}\n"
        printf "\n"

        delete_this_branch=$delete_all

        # Interative mode is on if we don't want to delete all branches.
        if [[ $delete_this_branch -ne 1 ]]; then
            read -p "Delete branch (y/n/a/q)? " -n 1 -r
            echo    # (optional) move to a new line
            if [[ $REPLY =~ ^[Yy]$ ]]
            then
                delete_this_branch=1
            elif [[ $REPLY =~ ^[Nn]$ ]]
            then
                echo "Continuing..."
            elif [[ $REPLY =~ ^[Aa]$ ]]
            then
                echo "Deleting all branches..."
                delete_this_branch=1
                delete_all=1
            elif [[ $REPLY =~ ^[Qq]$ ]]
            then
                echo "Quitting"
                # Handle exit from shell or function but don't exit interactive shell.
                [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
            fi
            echo ""
        fi

        if [[ $delete_this_branch -eq 1 ]]; then
            echo "Branch $branch marked for deletion."
            if [[ $do_delete -eq 1 ]]; then
                echo "Deleting..."
                git push --delete origin $short_branch
            else
                echo "Dry run only, use -d to actually delete."
            fi
            echo ""
        fi
    fi
done
