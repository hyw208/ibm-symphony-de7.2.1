FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y rpm python python-pip wget gettext bc net-tools lib32z1 curl

# assume you brought up http server making .bin & .dat available at address http://192.168.1.11:8000
RUN wget -P /home/docker/ibm http://192.168.1.11:8000/symdeeval-7.2.1.0_x86_64.bin
RUN wget -P /home/docker/ibm http://192.168.1.11:8000/sym_adv_ev_entitlement.dat

# install bin in non-interactive mode
RUN chmod +x /home/docker/ibm/symdeeval-7.2.1.0_x86_64.bin
RUN export CLUSTERADMIN=root && /home/docker/ibm/symdeeval-7.2.1.0_x86_64.bin --quiet

# add start script & exec start.sh
ADD ./start.sh /home/docker/ibm/start.sh
RUN chmod +x /home/docker/ibm/start.sh
ENTRYPOINT ["/home/docker/ibm/start.sh"]


