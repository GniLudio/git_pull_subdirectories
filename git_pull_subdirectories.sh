#!/bin/bash

# Functions
function for_all_subdirs()
{
  local action_name="$1"
  local action=$2
  echo $action_name
  for subdir in `ls`
  do
    if [ -d "$subdir" ]
    then
      cd "$subdir"
      if [ -d ".git" ]
      then
        echo "   $subdir"
        $action &
      else
        echo "Skipping $subdir."
      fi
      cd ".."
    fi
  done
  wait
  echo "Done $action_name at `date`."
  echo
}
function git_fetch() {
  git fetch --quiet
}
function git_reset() {
  git reset --quiet
}
function git_pull() {
  git pull --quiet
}

# Main
echo "Pulling all subdirectories in `pwd`/ at `date`."
echo

for_all_subdirs "Fetching" git_fetch
for_all_subdirs "Resetting" git_reset
for_all_subdirs "Pulling" git_pull

echo "Done all at `date`."
read -p "Press any key to close the terminal." -n 1
