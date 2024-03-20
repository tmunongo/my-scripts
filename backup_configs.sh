#!/bin/bash

backup_dir="$HOME/Documents/configs_backup"
date=$(date +%F_%H-%M-%S)

# Create backup directory if it does not exist
if [ ! -d "$backup_dir" ]; then
  mkdir "$backup_dir"
  cd "$backup_dir"
  git init
fi

# Create i3 backup directory if it does not exist
i3_dir="$backup_dir/i3"
if [ ! -d "$i3_dir" ]; then
  mkdir "$i3_dir"
fi

# Create neofetch backup directory if it does not exist
neofetch_dir="$backup_dir/neofetch"
if [ ! -d "$neofetch_dir" ]; then
  mkdir "$neofetch_dir"
fi

# Create polybar backup directory if it does not exist
polybar_dir="$backup_dir/polybar"
if [ ! -d "$polybar_dir" ]; then
  mkdir "$polybar_dir"
fi

# Backup i3 config
cp -r ~/.config/i3 "$i3_dir/$date"

# Backup neofetch config
cp -r ~/.config/neofetch "$neofetch_dir/$date"

# Backup polybar config
cp -r ~/.config/polybar "$polybar_dir/$date"

# Commit changes to git repository
cd "$backup_dir"
git add .
git commit -m "Backup $(date +"%Y-%m-%d_%H-%M-%S")"
