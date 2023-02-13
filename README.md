# Nsa Ansible

This repository contains files in order to setup a complete CI/CD pipeline.

- Continuous Integration (CI): Integrate code changes on the server hosting the application 
- Continuous Delivery (CD): Make the app available to the end users
  
A specific server has been setup with docker in order to host a gitlab server, it is accessible at the following address: https://gitlab.students-epitech.ovh

You can access the gitlab using the following credentials:

- Admin: root
- Password: foobarfoobar
- New registration are pending until administrator(s) approvals
  
In order to register a runner you will need to issue the following command: 

```bash
docker exec -it <gitlab runner container name or id> gitlab-runner register
```

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

## Configurations

Gitlab pipelines uses the following environnement variables: 
- ANSIBLE_INVENTORY (type file, containing hosts inventory)
- ANSIBLE_VMS_REMOTE_USER (type variable, containing host user name)
- DATABASE_CHARSET (type variable, containing mysql database charset)
- DATABASE_COLLATION (type variable, containing mysql database collation)
- DATABASE_NAME (type variable, containing mysql database name)
- DATABASE_ROLLBACK_BRANCH_NAME (type variable, containing gitlab rollback branch name - source branch from which an approved pull request to target branch aka PROJECT_MAIN_BRANCH_NAME would trigger a database rollback operation - laravel rollback )
- DATABASE_ROLLBACK_STEP_COUNT (type variable, number of step to go back during database rollback operation)
- PROJECT_MAIN_BRANCH_NAME (type variable, main project branch aka main or master)
- SSH_VMS_PRIVATE_KEY (type file, containing SSH private key to connect to hosts)