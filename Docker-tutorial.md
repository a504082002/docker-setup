#**Docker**

---

<div id="contents"></div>
##**Contents**
####1. [Basic commands](#basic)
#####1.1 [Get information](#get-info)
#####1.2 [Basic operations](#operations)
#####1.3 [Some advanced applications](#applications)
####2. [Writing a Dockerfile](#dockerfile)
####3. [Recommended docker apps](#recommend)
####4. [Docker commands diagram](#diagram)
####5. [Reference commands](#reference)

---

<div id="basic"></div>
###**Basic commands** <span>[↑](#contents)</span>

Usage:  `[sudo] docker [command] [flags] [arguments] ..`

<div id="get-info"></div>
####**Get information** <span>[↑](#contents)</span>

The version of docker:

	example> docker version
	Client version: 1.4.1
	Client API version: 1.16
	Go version (client): go1.3.3
	Git commit (client): 5bc2ff8
	OS/Arch (client): linux/amd64
	Server version: 1.4.1
	Server API version: 1.16
	Go version (server): go1.3.3
	Git commit (server): 5bc2ff8

Show the information about docker status:

	example> docker info
	Containers: 5
	Images: 5
	Storage Driver: aufs
	 Root Dir: /var/lib/docker/aufs
	 Dirs: 15
	Execution Driver: native-0.2
	Kernel Version: 3.13.0-32-generic
	WARNING: No swap limit support

<div id="operations"></div>
####**Basic operations** <span>[↑](#contents)</span>

Download image file provided from Docker Hub:

    docker pull <image-name>
	example> docker pull ubuntu:14.04

Run specified cmd on this image:

	docker run <image-name> <cmd>
	example> # Run interactively in the foreground
	example> docker run -i -t ubuntu /bin/bash

>**Flags:**
> `-t` flag assigns a terminal inside our new container.
> `-i` flag allows us to make an interactive connection by grabbing the standard in (`STDIN`) of the container.
> `-d` flag tells Docker to run the container and put it in the background, to daemonize it.
> `-p` flag is new and tells Docker to map any required network ports inside our container to our host.
> `-P` flag, a shortcut for `-p`,  maps any required network ports exposed in our image to a high port (from the range 49153 to 65535) on the local Docker host.
> `-v` flag mount the host directory into container directory, ex `-v <host-dir>:<container-dir>` or `-v <container-dir>`
> `--name` flag assigns a name to this container
> `<image-name>`: ubuntu:14.04
> `<cmd>`: /bin/echo "hello world"

View info of container:

	docker inspect <container-id-or-name>
	example> 

Lists containers:

	example> # To check which docker is running
	example> docker ps
	example> # 
	example> docker ps -l
	example> # Show all docker in execution
	example> docker ps -a

Stops running containers:

	docker stop <container-id-or-name>
	example> # This will stop the container id of cfc68
	example> docker stop cfc68

Commit a modified image:

	docker commit <container-id-or-name> <image-name>
	example> docker commit -m="Add PHPUnit and xdebug" \
	example> -a="Huang Yi-Ming" aeeb1980c96e \
	example> ymhuang0808/phpunit-testing:php5.5.9

>**Flags:**
>`-m` flag is used to give a comment to this commit.
>`-a` flag declare the maintainer's name.

Remove the image:

	docker rmi <image-id>

Login Docker Hub (before you push a image to repository):

	example> docker login
	Username: [ENTER YOUR USERNAME] Password:
	Email: [ENTER YOUR EMAIL] Login Succeeded

Push image to the repository (usually on Docker Hub):

	docker push <image-name>
	example> docker push a504082002/ubuntu:14.04

Shows us the standard output of a container:

	docker logs

<div id="applications"></div>
####**Some advanced applications** <span>[↑](#contents)</span>

Query the port mapping of a container:

	docker port <container-id-or-name> <port-exposed>
	example> # which port was mapped to the port 5000 on container named of nostalgic_morse
	example> docker port nostalgic_morse 5000
	0.0.0.0:49155

Running a web application in docker:

	example> # we're going to run a Python Flask application with image: training/webapp
	example> docker run -d -P training/webapp python app.py

Assign command to specific docker:

	example> # Return to docker again after exit
	example> docker exec -t -i 0f83f1728262 bash

To remove docker that you don't need anymore:

	example> docker rm 0f83f1728262

To mount a host directory as a disk in docker:

	example> # Mount /myData into docker
	example> docker run -t -i -v /myData centos:centos6 bash

---

<div id="dockerfile"></div>
###**Writing a Dockerfile** <span>[↑](#contents)</span>
We already know how to get a image and modify it, then share it through Docker Hub. It can be more portable and easy to customize. Just write a script in Dockerfile, and then use `docker build` to build an image following the script in Dockerfile!

A demo of a Dockerfile:

	FROM tutum/apache-php:latest
	MAINTAINER Huang AMing 
	RUN sed -i 's/archive.ubuntu.com/free.nchc.org.tw/g' \
	  /etc/apt/sources.list
	RUN apt-get update \
	  && apt-get install -y php5-xdebug
	ADD https://phar.phpunit.de/phpunit.phar /usr/local/bin/
	RUN cd /usr/local/bin \ 
	  && chmod +x phpunit.phar \ 
	  && mv phpunit.phar phpunit

> **FROM**: what image would be the base to build
> **MAINTAINER**: declare the maintainer
> **RUN**: to run command in the container in order to build image
> **ADD**: to add file from *host OS* or *remote directory* to the specified *directory of  image*, the file would be unziped automatically if it is compressed

Build the image:

	docker build <the-Dockerfile-placed>
	example> # build image following the Dockerfile in the current directory and tag as ymhuang0808/phpunit-testing:php5.5.9
	example> docker build -t="ymhuang0808/phpunit-testing:php5.5.9" .

> **Flags:**
> `-t` flag assign the new image a tag

---

<div id="recommend"></div>
###**Recommended docker apps** <span>[↑](#contents)</span>
	docker pull sequenceiq/hadoop-ubuntu
	docker pull nginx  # official repos
	docker pull php  # official repos
	docker pull dockerfile/java
	docker pull dockerfile/python
	docker pull pypy  # official repos
	docker pull rocker/rstudio:latest

---

<div id="reference"></div>
###**Reference commands** <span>[↑](#contents)</span>
    attach    Attach to a running container
    build     Build an image from a Dockerfile
    commit    Create a new image from a container's changes
    cp        Copy files/folders from the containers filesystem to the host path
    diff      Inspect changes on a container's filesystem
    events    Get real time events from the server
    export    Stream the contents of a container as a tar archive
    history   Show the history of an image
    images    List images
    import    Create a new filesystem image from the contents of a tarball
    info      Display system-wide information
    inspect   Return low-level information on a container
    kill      Kill a running container
    load      Load an image from a tar archive
    login     Register or Login to the docker registry server
    logs      Fetch the logs of a container
    port      Lookup the public-facing port which is NAT-ed to PRIVATE_PORT
    pause     Pause all processes within a container
    ps        List containers
    pull      Pull an image or a repository from the docker registry server
    push      Push an image or a repository to the docker registry server
    restart   Restart a running container
    rm        Remove one or more containers
    rmi       Remove one or more images
    run       Run a command in a new container
    save      Save an image to a tar archive
    search    Search for an image in the docker index
    start     Start a stopped container
    stop      Stop a running container
    tag       Tag an image into a repository
    top       Lookup the running processes of a container
    unpause   Unpause a paused container
    version   Show the docker version information
    wait      Block until a container stops, then print its exit code

---

<div id="diagram"></div>
###**Docker Commands Diagram** <span>[↑](#contents)</span>

![Docker Commands Diagram](https://github.com/philipz/docker_practice/raw/master/_images/cmd_logic.png)