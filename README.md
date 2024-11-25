# Azure Application Gateway with Ansible managed backend pools

Windows and Linux backend servers under Azure Application gateway, provisioned
using Terraform. Ansible is used to manage backend servers. DNS records are created
using Cloudflare Terraform provider.

## Azure Application gateway diagram

![ansible_concept](./img/Azure_App_Gateway.drawio.png)

## Azure Application Gateway components

- **Frontend IP Configuration** — Defines the private or public IP address that receives requests to the application
  gateway.

- **Frontend Port** — Defines a port that accepts incoming requests to the application gateway.

- **Backend Pool** — A list of IP addresses or FQDNs where traffic is forwarded.

- **HTTP Settings** — Defines how the application gateway sends incoming traffic to backend servers by setting up a
  protocol, backend port, and timeout interval.

- **HTTP Listener** — Binds the **Frontend IP Configuration**, **Frontend Port**, and protocol together to listen for
  incoming requests.

- **SSL Certificate** — Used in HTTPS listeners to secure communication between the gateway and clients by enabling
  traffic encryption.

- **Routing Rules** — Binds **HTTP Listener**, **Backend Pool**, and **HTTP Settings** to define how traffic is routed
  to backend servers.

- **Health Probe** — Ensures that traffic is delivered only to healthy backend servers.

- **Gateway IP Configuration** — Binds an application gateway to a specific subnet, ensuring proper internal
  communication.

## Steps to configure Azure Application Gateway

- Deploy virtual network
- Deploy application gateway subnet
- Deploy application gateway public IP
- Associate gateway with subnet using `gateway_ip_configuration` block
- Define app gateway frontend ports (80, 443) by using `frontend_port` block
- Associate app gateway with public IP using `frontend_ip_configuration` block
- Define backend pools with app services FQDNs by using `backend_address_pool` block
- Define the way gateway communicates with backend via `http_settings` block
- Add http and https listeners to the app gateway using `http_listener` block
- Define routing rules to handle requests based on headers CN
- Create a Cloudflare DNS record for the app gateway public IP and test connection

## Related repositories

- https://github.com/kolosovpetro/packer-azure-windows-image
- https://github.com/kolosovpetro/azure-windows-vm-terraform

## Infrastructure

- Control node (SSH key authentication)
- DB server (Password authentication -> then copy id to be executed)
- Web server (Password authentication -> then copy id to be executed)
- Windows DB server (RDP)
- Windows Web server (RDP)

## DNS

### Servers

- http://ansible-control-node.razumovsky.me
- http://ansible-dbserver.razumovsky.me
- http://ansible-webserver.razumovsky.me
- http://ansible-win-dbserver.razumovsky.me
- http://ansible-win-webserver.razumovsky.me

### App gateway

DEV

- https://agwy-vm-dev.razumovsky.me
- http://agwy-vm-dev.razumovsky.me

QA

- https://agwy-vm-qa.razumovsky.me
- http://agwy-vm-qa.razumovsky.me

## SSH configuration for Linux managed nodes

From control node execute:

- Update `known_hosts` file by removing the old entries (if necessary)
- ssh razumovsky_r@ansible-control-node.razumovsky.me
- ssh-keygen
- ssh-copy-id -i ~/.ssh/id_rsa razumovsky_r@ansible-dbserver.razumovsky.me
- ssh-copy-id -i ~/.ssh/id_rsa razumovsky_r@ansible-webserver.razumovsky.me

## Control node initial configuration (Linux)

- Copy SSH key and configure permissions
    - `scp "$env:USER_DIRECTORY/.ssh/id_rsa" razumovsky_r@ansible.control.node.razumovsky.me:~/.ssh`
    - `ssh razumovsky_r@ansible.control.node.razumovsky.me "chmod 600 ~/.ssh/id_rsa"`
    - `ssh razumovsky_r@ansible.control.node.razumovsky.me`
- Validate Python installation
    - `git clone git@github.com:kolosovpetro/ansible-control-node.git`
    - `cd ansible-control-node`
    - Run `install_python.sh`
- Install Ansible
    - Run `install_ansible.sh`
- Copy Ansible global configuration file `ansible.cfg`
    - `sudo cp ansible.cfg /etc/ansible/ansible.cfg`
    - `scp ansible.cfg razumovsky_r@ansible.control.node.razumovsky.me:~/ansible.cfg`
    - `ssh razumovsky_r@ansible.control.node.razumovsky.me "sudo cp ~/ansible.cfg /etc/ansible/ansible.cfg"`
- Copy Ansible inventory file `inventory/inventory.yaml`
    - `sudo cp inventory/inventory.ini /etc/ansible/inventory.ini`
    - `scp "inventory/inventory.ini" razumovsky_r@ansible.control.node.razumovsky.me:~/inventory.ini`
    - `ssh razumovsky_r@ansible.control.node.razumovsky.me "sudo cp ~/inventory.ini /etc/ansible/inventory.ini"`
- Update inventory file `inventory/inventory.yaml` if necessary
- Check connection to Linux managed nodes
    - `ansible-playbook ping.yml`
- Windows nodes require additional configuration

## Managed nodes initial configuration (Windows)

- Login to your Windows machines via RDP
- Open PowerShell as Administrator
- Copy script contents from `Configure-Ansible-Host.ps1` to the terminal
- Check connection to Windows managed nodes
    - `ansible windows_servers -m win_ping`

## SSH connection commands (Linux managed nodes)

- ssh razumovsky_r@ansible-control-node.razumovsky.me
- ssh razumovsky_r@ansible-dbserver.razumovsky.me
- ssh razumovsky_r@ansible-webserver.razumovsky.me

## Ansible for Windows Docs

- https://docs.ansible.com/ansible/latest/os_guide/windows_winrm.html
- https://docs.ansible.com/ansible/latest/os_guide/windows_setup.html
- https://github.com/AlbanAndrieu/ansible-windows/blob/master/files/ConfigureRemotingForAnsible.ps1
- Set-ExecutionPolicy -ExecutionPolicy Bypass
- pip install "pywinrm>=0.3.0"
- Application gateway quizlet: https://quizlet.com/pl/975398961/azure-application-gateway-flash-cards/

## Links

- https://trello.com/c/HBFIS51g