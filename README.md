
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Untitled Diagram drawio](https://user-images.githubusercontent.com/102448690/160266683-4df89297-bb53-4828-9268-a98e0526d26e.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the yml file may be used to install only certain pieces of it, such as Filebeat.

  '---
  - name: Configure Elk VM with Docker
    hosts: elk
    remote_user: azadmin
    become: true
    tasks:
    - name: Install docker.io
      apt:
        update_cache: yes
        name: docker.io
        state: present

    - name: Install pyhton3-pip
      apt:
        force_apt_get: yes
        name: python3-pip
        state: present

    - name: Install Docker module
      pip:
        name: docker
        state: present

    - name: Use more memory
      sysctl:
        name: vm.max_map_count
        value: 262144
        state: present
        reload: yes

    - name: download and launch a docker elk container
      docker_container:
        name: elk
        image: sebp/elk:761
        state: started
        restart_policy: always
        published_ports:
          - "5601:5601"
          - "9200:9200"
          - "5044:5044"

    - name: Enable service docker on boot
      systemd:
        name: docker
        enabled: yes'

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting inbound access to the network.


Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the file systems and system metrics.

The configuration details of each machine may be found below.


| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box |Gateway   | 10.0.0.1   | Linux            |
| Web-1    |Web Server| 10.0.0.5   | Linux            |
| Web-2    |Web Server| 10.0.0.6   | Linux            |
| ELK      |Web Server| 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the JumpBox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 97.118.152.115

Machines within the network can only be accessed by each other.

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |  
|----------|---------------------|----------------------|
| Jump Box | Yes                 | 10.0.0.5 10.0.0.6    |
| ELK      | No                  | 10.0.0.5-10          |
| Web-1    | No                  | 10.1.0.4             |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- Configuring VMs manually can be time consuming and poses the risk of incorrectly configuring.

The playbook implements the following tasks:
- Install Docker
- Install python-3
- download and launch a docker elk container

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.
'CONTAINER ID   IMAGE          COMMAND                  CREATED      STATUS         PORTS                                                                              NAMES
3f5552020788   sebp/elk:761   "/usr/local/bin/star…"   7 days ago   Up 5 minutes   0.0.0.0:5044->5044/tcp, 0.0.0.0:5601->5601/tcp, 0.0.0.0:9200->9200/tcp, 9300/tcp   elk' 

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.0.0.5
- 10.0.0.6

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat detects changes to the file system. We expect to see file types that have come across the webservers.
- Metricbeat detects changes in system metrics. We expect to see failed SSH login attempts.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the yml file to /etc/Ansible.
- Update the hosts file to include the ip addresses of the machines you want to target
- Run the playbook, and navigate to http://elk-vm-ip:5601 to check that the installation worked as expected.
