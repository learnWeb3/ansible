# Nsa Ansible

This repository contains files in order to setup a complete CI/CD pipeline.

- Continuous Integration (CI): Integrate code changes on the server hosting the application 
- Continuous Delivery (CD): Make the app available to the end users

The application is deployed on three different servers communicating with each others:
- database host with mysql server
- server host with php 
- frontend host with node js

Database host has been configured in order to be accessible from the external world (external traffic)

Server and frontend host run behind an nginx load balancer in order to accessible from the external world and from each others.

All the setup on the hosts is done using Ansible playbooks (one per server) and three ansible roles allowing to mutualize some of the tasks.

Ansible roles:

- initialize: update and upgrade server packages
- project_copy: copy project dependencies from gitlab runner (docker container) to the remote host
- expose: configure nginx as a load balancer and SSL certificates using certbot

Ansible playbooks: 

- database_playbook: setup mysql server with two users (root and admin), setup external access to mysql server for the admin user.
- server_playbook: setup php 7.4 complete environnement and composer php dependencies manager
- frontend_playbook: stup node 12.0 complete environnement and npm nodejs dependencies manager.

Ansible extract host informations from a special file the inventory file containing all requested information in order to connect to the hosts.

Applications are accessible at the following URL: 
- frontend: https://nsa-frontend.students-epitech.ovh/
- backend api: http://nsa-server.students-epitech.ovh/
- mysql: 
```bash  
  mysql -u admin -h $MYSQL_SERVER_IP
```