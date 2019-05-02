## Deployment infrastructure for radiam project

# Deploy docker registry

*Purpose*: Store static images versions of external projects and latest stable builds of the radiam project.

*Howto*: ansible-playbook -i <inventory file (.ini)> registry-hosts.yml

*Notes*: The radiam-api and radiam-gui images are pushed to this repository externally. Currently, this is done by the usask jenkins build server

# Deploy single-host radiam-api

*Purpose*: Deploy radiam-api and radiam-gui projecs on a single host.

*Howto*: ansible-playbook -i <inventory file (.ini)> radiam-singlenode.yml

*Notes*: Need credentials for radiam-api repo to run this playbook. New images will automatically be pulled from the docker registry every fifteen minutes; this can be done manually by running 'sudo systemctl reload docker-compose' on the singlenode host.
