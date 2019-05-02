## Deployment infrastructure for radiam project

# Deploy docker registry

*Purpose*: Store static images versions of external projects and latest stable builds of the radiam project.

*Howto*: ansible-playbook -i <inventory file (.ini)> registry-hosts.yml

*Notes*: The radiam-api and radiam-gui images are pushed to this repository externally. Currently, this is done by the usask jenkins build server


