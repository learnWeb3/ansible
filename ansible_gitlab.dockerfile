FROM --platform=linux/amd64 ubuntu:22.04 

ARG ANSIBLE_VERSION=2.14.1

RUN apt update
RUN apt install software-properties-common -y
RUN apt install openssh-client -y
RUN apt install openssh-server -y
RUN apt install python3-pip -y
RUN apt update
RUN python3 -m pip install ansible-core==${ANSIBLE_VERSION}

CMD ["/bin/bash"]