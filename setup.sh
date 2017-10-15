#!/bin/bash

BASHRC_PATH="$HOME/.bashrc"

if [ ! -f $BASHRC_PATH ]
then
  echo "No ~/.bashrc file found. Exiting..."
  exit 1
fi

# ask whether to continue if .bashrc already contains the config
if grep -q '# common config - BEGIN' $BASHRC_PATH
then
  echo "~/.bashrc already contains the config."
  while true; do
    read -p "Do you wish to continue? [y/n] " yn
    case $yn in
        [y]* ) break;;
        [n]* ) exit 1;;
        * ) echo "Please answer yes or no.";;
    esac
  done
fi

# create backup directory if it doesn't exist
if [ ! -d ./.backup ]
then
  mkdir .backup
fi

# backup .bashrc if desired
if [ -f .backup/.bashrc ]
then
  echo ".bashrc is already backed up."
  while true; do
    read -p "Do you wish to overwrite this backup? [y/n] " yn
    case $yn in
        [y]* ) cp $BASHRC_PATH ./.backup/.bashrc; break;;
        [n]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
  done
else
  cp $BASHRC_PATH ./.backup/.bashrc
fi

# append the config to .bashrc
SCRIPT_DIR=$(pwd)
echo "# common config - BEGIN" >> $BASHRC_PATH
echo "# https://github.com/JakubPetriska/common-config" >> $BASHRC_PATH
echo "export PATH=\"\${PATH}:${SCRIPT_DIR}/bin\"" >> $BASHRC_PATH
echo "source ~/aliases.sh" >> $BASHRC_PATH
echo "# common config - END" >> $BASHRC_PATH
echo >> $BASHRC_PATH

echo "Config successfully appended to .bashrc"
