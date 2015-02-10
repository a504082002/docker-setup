# Docker-setup

This is a personal setup file for docker.

### **Features**
* mapping service exposed port to host high port (49153~65535) automatically
* mount your home directory onto container the same place automatically

### **Applications support**
* rstudio

## **How to use**
just pull the bash script down to your local directory:

	git clone https://github.com/a504082002/docker-setup.git

change the mode of the file to be executable:

	chmod +x docker_up.sh
	chmod +x docker_stop.sh

then execute the script and specify the app you want:

	./docker_up.sh rstudio

follow the instruction show up in terminal
then......have fun!

### **To terminate while you finish it**
just execute the script, it would terminate for you:

	./docker_stop.sh andy_rstudio

remember to specify the container name!