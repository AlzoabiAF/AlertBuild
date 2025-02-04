#!/bin/bash

SCRIPT_DIR=$(dirname $(realpath "$BASH_SOURCE"))

shc -rvf $SCRIPT_DIR/main.sh -o $SCRIPT_DIR/alertbuild 
sudo mv $SCRIPT_DIR/alertbuild /usr/local/bin