# symphony
create docker image for ibm symphony developer edition 7.2.1 

####################################################################################
# goal: create symphony vm with docker-machine
# assume ibm symphony bin & dat are downloaded and Dockerfile & start.sh are here too
# create a vm called symphony and assign 4G memory: docker-machine create --virtualbox-memory "4096" symphony
# create /home/docker/ibm onto vm so we can push files later used to build docker image: docker-machine ssh symphony mkdir -p /home/docker/ibm 
# ssh Dockerfile to vm, used to build the ibm symphony image: docker-machine scp Dockerfile symphony:/home/docker/ibm 
# ssh start.sh to vm, used to start the ibm symphony cluster: docker-machine scp start.sh symphony:/home/docker/ibm 

####################################################################################
# goal: bring up python http server for bin & dat to be downloaded with wget in image building
# cd to directory containing ibm symphony bin & dat
# assuming you have python installed, run cmd: python -m SimpleHTTPServer 8000

####################################################################################
# goal: build docker image called "cbb"
# ssh to symphony vm: docker-machine ssh symphony
# go to ibm directory created before: cd /home/docker/ibm
# build cbb image: docker build -t cbb .
# check docker image built, look for "cbb": docker images

####################################################################################
# goal: run ibm symphony cluster, version de721
# run docker image cbb, 18080 is the port in container where 80 is the port on host, symphony vm in this case: docker run -d -p 80:18080 cbb

# optional to exec into the running container, use docker ps to find continer eg 123...: docker exec -it 123 /bin/bash
# source env so as to execute the cmd below: . /opt/ibm/spectrumcomputing/symphonyde/de721/conf/profile.soam
# ensure de721 has started: soamview app
# ensure cluster is working: symping
# check gui http url: start_agent -u

# to access ibm symphony dashboard in browser
# find out symphony vm ip, eg. tcp://192.168.99.99:2345: docker-machine ls 
# combine ip with mapped port 80, you get symphony dashboard url: http://192.168.99.99:80/platform or just http://192.168.99.99/platform

####################################################################################
# references: 
# ibm symphony knowledge center: https://www.ibm.com/support/knowledgecenter/en/SSZUMP_7.2.0/sym_kc_welcome.html
# ibm symphony binary: https://www.ibm.com/us-en/marketplace/analytics-workload-management (click on start free trial)
# ibm symphony installation guide: https://www.ibm.com/support/knowledgecenter/en/SSZUMP_7.2.0/install/install_linux_management.html
# python http server to download binary & entitlement to docker, cmd: python -m SimpleHTTPServer 8000 
# docker machine reference: https://docs.docker.com/machine/get-started/#run-containers-and-experiment-with-machine-commands

####################################################################################
