#!/bin/bash

FILEMAP_PATH="filemap"
FILES_DIR="files"

echo "Copying updated versions of config files"
while IFS=' ' read -r file_name file_path
do
  if [ -e "$HOME/$file_path" ]
  then
    printf "  %s -> %s\n" "$HOME/$file_path" "$FILES_DIR/$file_name"
    cp "$HOME/$file_path" "$FILES_DIR/$file_name"
  else
    printf "  %s not found\n" "$HOME/$file_path"
  fi
done <"$FILEMAP_PATH"
