# Create & use docker image for ibm symphony developer edition 7.2.1 

# Goal: create symphony vm with docker-machine:
1. assume ibm symphony bin (binary) & dat (entitlement), Dockerfile and start.sh are downloaded in one directory
2. create a 4G vm called symphony: docker-machine create --virtualbox-memory "4096" symphony
3. create /home/docker/ibm on vm to stash files needed for building docker image: docker-machine ssh symphony mkdir -p /home/docker/ibm 
4. ssh Dockerfile to vm, used to build the ibm symphony image: docker-machine scp Dockerfile symphony:/home/docker/ibm 
5. ssh start.sh to vm, used to start the ibm symphony cluster: docker-machine scp start.sh symphony:/home/docker/ibm 

# Goal: bring up python http server for bin & dat to be downloaded with wget in image building:
1. cd to directory containing ibm symphony bin & dat & Dockerfile & start.sh
2. assuming you have python installed, run cmd: python -m SimpleHTTPServer 8000

# Goal: build docker image called "cbb":
1. ssh to symphony vm: docker-machine ssh symphony
2. on vm, cd to ibm directory created before: cd /home/docker/ibm
3. build cbb image: docker build -t cbb .
4. check docker image built, look for "cbb": docker images

# Goal: run ibm symphony cluster, version de721:
1. run docker image cbb, 18080 is the port in container where 80 is the port on host, symphony vm in this case: docker run -d -p 80:18080 cbb

# Goal: to exec into the running container:
1. use docker ps to find continer eg 123...: docker exec -it 123 /bin/bash
2. source env so as to execute the cmd below: . /opt/ibm/spectrumcomputing/symphonyde/de721/conf/profile.soam
3. ensure de721 has started: soamview app
4. ensure cluster is working: symping
5. check gui http url: start_agent -u (** this url is not correct, see below "to access ibm symphony dashboard in browser" to get the right url **)
6. now it's ready for you to use 

# Goal: to access ibm symphony dashboard in browser:
1. find out symphony vm ip, eg. tcp://192.168.99.99:2345: docker-machine ls 
2. combine ip with mapped port 80, you get symphony dashboard url: http://192.168.99.99:80/platform or just http://192.168.99.99/platform (** if it doesn't work, need to port forwarding for docker-machine **)

# References: 
1. ibm symphony knowledge center: https://www.ibm.com/support/knowledgecenter/en/SSZUMP_7.2.0/sym_kc_welcome.html
2. ibm symphony binary (bin) & entitlement (dat) download: https://www.ibm.com/us-en/marketplace/analytics-workload-management (click on start free trial)
3. ibm symphony installation guide: https://www.ibm.com/support/knowledgecenter/en/SSZUMP_7.2.0/install/install_linux_management.html
4. docker machine reference: https://docs.docker.com/machine/get-started/#run-containers-and-experiment-with-machine-commands

# Next:
1. deploy sample code
2. create & deploy dummy service, app and client
