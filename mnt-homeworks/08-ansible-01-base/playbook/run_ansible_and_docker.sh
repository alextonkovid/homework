#!/bin/bash

# Run Ansible playbook with vault password
ansible-playbook -i ./inventory/test.yml site.yml
# Check if the Ansible playbook was successful (check the return code)
if [ $? -eq 0 ]; then
    # If the playbook ran successfully, stop and remove the "fedora" Docker container
    docker stop fedora
    docker rm fedora
else
    echo "Ansible playbook execution failed. Skipping Docker operations."
fi

