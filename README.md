# Automated Docker Installation system (mac OS X)
The point of this repository is to install/uninstall docker. The main file in this is `install.sh` and `Makefile`. The `Makefile` can be used by simply running `make`


## To use

### Install
Run `make install`

in order to install docker

### Uninstall

Run `make uninstall`

in order to uninstall docker

### Commands
At the current moment, the list will be as shown

```bash
hw                             Runs docker run hello-world
install                        Installs docker
restart                        restarts docker default instance
setup                          Setup the default instances of docker
start                          starts default docker instance
stop                           stops the default docker instance
uninstall                      Uninstalls docker
```

You can also run `./install.sh` in order to see a list of commands, the current commands are:

```bash
Welcome to the Docker installation Script. Below are the following commands: 

help			Help documentation, auto-generated with ## comments
hw			Runs docker run hello-world
evaluate		Sets the environmental variable for docker-machine to default
install			Installs docker
restart			restarts docker default instance
setup			Setup the default instances of docker
start			starts default docker instance
stop			stops the default docker instance
uninstall		Uninstalls docker
```

Thus, invoking `make install` will install docker. The requirements for docker require a user to have a mac system at the moment as `homebrew` is used to install `docker`, `docker-machine`, `docker-compose` and `virtualbox`.


If any edits are made to the `install.sh` file, please place the function in the following syntax in order to auto-generate `help`

```bash
## comments that will be on the left
function someFunction() {
  blah... blah...
}
```

In doing so, it will parse the text with any `##` and set that to the description of the function and the function() will be set on the left.
