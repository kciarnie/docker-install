# --------------------------------------------------------------------
# Copyright (c) 2020 All Rights Reserved.
# Author(s): Kevin Ciarniello
#
# This software may be modified and distributed under the terms of the
# MIT license. See the LICENSE file for details.
# --------------------------------------------------------------------

.ONESHELL: 
SHELL := /bin/bash

.PHONY: install restart setup start stop uninstall help

hw: ## Runs docker run hello-world
	@./install.sh hw
	
eval:
	@./install.sh evaluate

install: ## Installs docker
	@./install.sh install

install-brew: # Install homebrew (dependency installer)
	@./install.sh install_brew

restart: ## restarts docker default instance
	@./install.sh restart

setup: ## Setup the default instances of docker
	@./install.sh setup


start: ## starts default docker instance
	@./install.sh start

stop: ## stops the default docker instance
	@./install.sh stop

uninstall: ## Uninstalls docker
	@./install.sh uninstall


# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: # This help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help