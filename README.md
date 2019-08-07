## Deployment infrastructure for radiam project

# Deploy docker registry

*Purpose*: Store static images versions of external projects and latest stable builds of the radiam project.

*Howto*: ansible-playbook -i <inventory file (.ini)> registry-hosts.yml

*Notes*: The radiam-api and radiam-gui images are pushed to this repository externally. Currently, this is done by the usask jenkins build server

# Deploy single-host radiam-api

** DEPRECATED **

*Purpose*: Deploy radiam-api and radiam-gui projecs on a single host.

*Howto*: ansible-playbook -i <inventory file (.ini)> radiam-singlenode.yml

*Notes*: Need credentials for radiam-api repo to run this playbook. New images will automatically be pulled from the docker registry every fifteen minutes; this can be done manually by running 'sudo systemctl reload docker-compose' on the singlenode host.

# Deploy docker and SSL support on Jenkins test server.

*Purpose*: Get docker support on Jenkins test server and SSL certs configured in a way to be able to test run the prod.yml deployment.

*Howto*: ansible-playbook -i <inventory file (.ini)> radiam-jenkins.yml

# Deploy full radiam stack on swarm hosts:

*Purpose*: Deploy radiam api and gui on a docker swarm cluster.

*Howto*: ansible-playbook -i <inventory file (.ini)> deploy-swarm.yml --vault-password-file=<local vault password file>
