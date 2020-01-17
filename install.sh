#!/bin/bash
#
# Installs/Uninstalls docker
#
# --------------------------------------------------------------------
# Copyright (c) 2020 All Rights Reserved.
# Author(s): Kevin Ciarniello
#
# This software may be modified and distributed under the terms of the
# MIT license. See the LICENSE file for details.
# --------------------------------------------------------------------

# This program
PROG=$0

# The first ARGUMENT
ARG1="$1"

# The color BLUE (Used for printf)
BLUE="\033[36m"

# The color WHITE (Used for printf)
WHITE="\033[0m"

# Begins with a function in the line
FUNCTION_LINE="function "

## Help documentation, auto-generated with ## comments
function help() {
    printf $BLUE"Welcome to the Docker installation Script. Below are the following commands: \n\n"$WHITE
    awk '/^##/{ 
        sub("## ", "", $0)
        getline functions;
        regex="function "
        where = match(functions, regex)
        if (where != 0) {
            sub(regex, "", functions)
            sub("\\(\\) {", "", functions)
            value=int(length(functions) / 8)
            printf "'$BLUE'"functions"'$WHITE'"
            for (i=0; i < 3-value; i++) { 
                printf "\t" 
            }
            printf $0 "\n"
        }

        }' $PROG |
    
    while read line; do
        printf "$line\n"
    done;
}

## Runs docker run hello-world
function hw() {
    docker run hello-world 2>/dev/null

    if [ $? -ne 1 ]; then
        echo "Run this command to configure your shell: "
        echo "eval \$(docker-machine env default)"
    fi
}

# Checks to see if docker is installed
function docker_check() {
    if command_exists docker version; then
        echo "Docker is already installed."
        exit 1
    fi
}

# Checks to see if the function exists
function command_exists() {
    command -v "$@" >/dev/null 2>&1
}

# Adds the standardized semi-colon and space into the question and asks for an input
function question_input() {
    read -p "$@: "
}

## Sets the environmental variable for docker-machine to default
function evaluate() {
    if command_exists docker-machine; then
        eval $(docker-machine env default) 
    else
        echo "Please install docker"
    fi
}

## Installs docker
function install() {
    if command_exists docker-machine version; then
        echo "Docker is installed"
    else
        install_brew
        install_docker
    fi
}

# Brew commands in order to install docker, change permissions and start services
function install_docker() {
    echo "Installing docker..."

    brew install docker docker-machine docker-compose
    brew cask install virtualbox
    chmod +x /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker
    chmod +x /usr/local/bin/docker-machine

    restart
    setup
}

# Install homebrew (dependency installer)
function install_brew() {
    echo "Checking to see if homebrew installed..."
    if command_exists brew --version; then
        question_input "Would you like to update brew? [y/N]"
        if [[ $REPLY =~ ^[Yy] ]]; then
            brew update
        fi
    else
        echo "Brew needs to be installed"
    fi
}

## restarts docker default instance
function restart() {
    brew services restart docker-machine
}

## Setup the default instances of docker
function setup() {
    if [ -z "$1" ]; then
        question_input "Please enter a container name? [default]"
        name=$REPLY
        if [ -z $REPLY ]; then
            name="default"
        fi
    else
        name=$1
    fi

    echo "Container name: $name"
    docker-machine create --driver virtualbox $name
    docker-machine start $name
    docker-machine env $name
    eval $(docker-machine env $name)
    docker run hello-world
}

## starts default docker instance
function start() {
    brew services start docker-machine
}

## stops the default docker instance
function stop() {
    brew services stop docker-machine
}

## Uninstalls docker
function uninstall() {
    if ! command_exists docker-machine version; then
        echo "Docker is already uninstalled."
    else
        remove_docker
    fi
}

# Removes docker
function remove_docker() {
    question_input "Are you sure you want to remove docker? [y/N]"

    if [[ $REPLY =~ ^[Yy] ]]; then
        docker-machine stop default
        docker-machine rm default

        brew services stop docker-machine
        brew uninstall docker docker-machine docker-compose
        brew cask uninstall virtualbox
    fi
}

# Check if the function exists (bash specific)
if [[ -z $ARG1 ]] || [ $ARG1 = '-h' -o $ARG1 = '-H' -o $ARG1 = '--help' ]; then
    help
elif declare -f $ARG1 >/dev/null; then
    # call arguments verbatim
    "$@"
else
    # Show a helpful error
    echo "$ARG1 is not a known function name" >&2
    exit 1
fi