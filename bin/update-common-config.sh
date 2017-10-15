#!/bin/bash

COMMON_CONFIG_ZIP_URL="https://github.com/JakubPetriska/common-config/archive/master.zip"

CACHE_DIR="$HOME/.cache"
SCRIPT_CACHE_DIR="$CACHE_DIR/common-config"
DOWNLOADED_ZIP_PATH="$SCRIPT_CACHE_DIR/common-config.zip"
UNZIPPED_DIR="$SCRIPT_CACHE_DIR/common-config-master"
BACKUP_DIR="$SCRIPT_CACHE_DIR/backup"
FILEMAP_PATH="$UNZIPPED_DIR/filemap"
FILES_DIR_PATH="$UNZIPPED_DIR/files"

# create cache dir and script's dir in it if they don't exist
if [ ! -d $CACHE_DIR ]
then
  mkdir $CACHE_DIR
fi
if [ ! -d $SCRIPT_CACHE_DIR ]
then
  mkdir $SCRIPT_CACHE_DIR
fi

# delete old downloaded zip and unzipped dir if they exist
if [ -e $DOWNLOADED_ZIP_PATH ]
then
  rm $DOWNLOADED_ZIP_PATH
fi
if [ -e $UNZIPPED_DIR ]
then
  rm -r $UNZIPPED_DIR
fi

# download the zip of repo's master and unzip it into script's dir in cache
curl -sLk $COMMON_CONFIG_ZIP_URL -o $DOWNLOADED_ZIP_PATH
unzip -q $DOWNLOADED_ZIP_PATH -d $SCRIPT_CACHE_DIR

# create backup directory if it doesn't exist
if [ ! -e $BACKUP_DIR ]
then
  mkdir $BACKUP_DIR
fi

# backup old config files
echo "Backing up old config files"
while IFS=' ' read -r file_name file_path
do
  if [ -e "$HOME/$file_path" ]
  then
    printf "  %s -> %s\n" "$HOME/$file_path" "$BACKUP_DIR/$file_name"
    cp "$HOME/$file_path" "$BACKUP_DIR/$file_name"
  fi
done <"$FILEMAP_PATH"

echo

# copy over the new config files
echo "Copy over the new config files"
while IFS=' ' read -r file_name file_path
do
  printf "  %s -> %s\n" "$FILES_DIR_PATH/$file_name" "$HOME/$file_path"
  cp "$FILES_DIR_PATH/$file_name" "$HOME/$file_path"
done <"$FILEMAP_PATH"
