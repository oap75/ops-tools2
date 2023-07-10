# Parachain collator deployment instructions

## Scripts overview

- [collator.sh](collator.sh) 
  - runs a parachain collator service.
- [stop-collator.sh](stop-collator.sh) 
  - stops a parachain collator service.
- [full-node.sh](full-node.sh) 
  - runs a parachain full node.
  - `archive` can be provided as the argument to run the archive node. Example: `./full-node.sh archive`
- [stop-full-node.sh](stop-full-node.sh) 
  - stops a parachain collator service.
- [get-kusama-snapshot.sh](get-kusama-snapshot.sh) 
  - downloads the latest Kusama network snapshot.
- [insert-keys.sh](insert-keys.sh) 
  - inserts keys from [aura.json](data/aura.json) files into a collator service node.

## Install required tools on the server

- You must disable the SSH password authentication on your server.
    - Just use `authorized_keys` (SSH) to login to it.

### Create a user with sudo permission:
```sh
sudo adduser ops
sudo usermod -aG sudo ops
```

To log in as the newly created user, use `sudo su - ops`. 

If you get an error, create a home directory and change owner to `ops` user with the following commands:
```sh
sudo mkdir /home/ops
sudo chown -R ops:ops /home/ops
```

### (Optional) Prepare the Kusama network snapshot

If you don't want to wait until the Kusama full node of your parachain is synced, run the [get-kusama-snapshot.sh](./get-kusama-snapshot.sh) script to download it from a snapshot.

After you have run the node for the first time:
1. Stop it with [stop.sh](./stop-collator.sh) script.
2. Move the snapshot to an appropriate directory (as root):
```sh
sudo rm -rf /home/ops/data/polkadot/chains/ksmcc3/*
sudo mv /home/ops/kusama-snapshot/* /home/ops/data/polkadot/chains/ksmcc3/
```

### Docker installation

1.
```sh
sudo apt-get update && sudo apt update && sudo apt-get upgrade -y && sudo apt upgrade -y
```

2.
```sh
sudo apt-get install \
  ca-certificates \
  curl \
  gnupg \
  lsb-release
```

3.
```sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

4.
```sh
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

5. `sudo apt-get update`
6.
```sh
sudo apt-get install docker-ce=5:20.10.11~3-0~ubuntu-focal  docker-ce-cli=5:20.10.11~3-0~ubuntu-focal containerd.io -y
```

7. `sudo nano /etc/docker/daemon.json` (open the file and paste the content below):
```
{
    "exec-opts": ["native.cgroupdriver=systemd"],
    "log-driver": "json-file",
    "live-restore": true,
    "log-opts": {
        "max-size": "100m"
    },
    "storage-driver": "overlay2"
}
```

8. `sudo mkdir -p /etc/systemd/system/docker.service.d`
9. `sudo systemctl start docker && sudo systemctl enable docker`

### Docker-compose installation

1.
```sh
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
```

2. `sudo chmod +x /usr/local/bin/docker-compose`
3. `docker-compose --version` (for install verification)

### Permit your user to run docker without sudo:


1. `sudo groupadd docker`
2. `sudo gpasswd -a $USER docker` (change `$USER` to your username).

### Install jq:


1. `sudo apt install jq -y`
2. `jq --version` (install verification)


## Deployment configuration

### Create and add ssh key for CD pipeline

1. `ssh-keygen -t rsa -b 4096` will generate RSA ssh keys (press Enter for each question to set ssh key)
2. Copy the content of the *id_rsa* (private key --> this sould be paste into the parachain repo Github Secret under name **KEY**).
```sh
cat .ssh/id_rsa
```

3. Copy the content of *id_rsa.pub* (public key --> this should be paste into the collator server).
```sh
cat .ssh/id_rsa.pub
```

4. **Login to collator server** and then open the `authorized_keys` file and paste the public key content (from step 3) to the bottom of the file , then save the file and exit.
```sh
mkdir .ssh; \
touch .ssh/authorized_keys; \
chmod 700 .ssh;\
chmod 600 .ssh/authorized_keys; \
nano .ssh/authorized_keys
```

### Prepare server and github action to launch the CD process

1. Copy the content of the `ops-tools/subsocial-parachain` into the server (on the home DIR of the user is preferred).
2. `chmod 777 -R ./data` (change the data DIR permission).

### Run the CI/CD process by ...

### After CI/CD process you must login to server and import your keys.

1. Put needed keys in `aura.json` in the `data` directory.
2. Execute script: `./insert-keys-one.sh` or `./insert-keys-two.sh`
4. Remove the `aura.json` file
5. Run `docker exec -it subsocial-collator-1 rm -rf /bin/*` or `docker exec -it subsocial-collator-2 rm -rf /bin/*` (better not to do before parachain is producing blocks)
    - This will remove permission to execute commands in the container.
