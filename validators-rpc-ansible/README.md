# Deloyment instructions

## Install required tools on your Local Host

- You have to install ansible & openssh-server on your localhost.
    - On `debian based distributions`:
      ```
      sudo apt --fix-broken install
      sudo apt-get install openssh-server ansible -y      
      ```
    - On `mac`:
      ```
      brew install ansible
      Go to System Preferences -> Sharing, enable Remote Login. (for ssh server)
   
      ```

- You should have docker and docker-compose on your Server or Localhost too . 


### Server or Local Host Preparation and files

1.
- Copy the content of validators-rpc-files DIR into your specific `PATH` on your local host or server

2.
- Change the `/home/ops/nodes/validator/internal/` PATH in the `rpc.sh` & `validators.sh`  to your specific `PATH` in validators-rpc-files DIR

3.
- Change the `/home/ops/nodes/validator/internal/` PATH in the `roles/rpc/tasks/main.yml` & `roles/validators/tasks/main.yml` to your specific `PATH`

4. 
- Change the IP content of the `inventory` file . (set `127.0.0.1` for `localhost`)

5.
- Change the remote_user content of the `rpc.yaml`,`validators.yml` files in root of the validators-rpc-ansible . (set user of the localhost or remote server)

6.
- Change the become_user content of the `roles/rpc/tasks/main.yml`,`roles/validators/tasks/main.yml` files . (set user of the localhost or remote server)



### Ansible Instructions 

1. 
- Run the `validators-playbook.sh` in root of the validators-rpc-ansible to launch a fresh network with custome keys.
```
./validators-playbook.sh
```

2 . 
- Run the `rpc-playbook.sh` in root of the validators-rpc-ansible DIR to launch a fresh `RPC` node.
```
./rpc-playbook.sh
```

