# Deployment instructions

## Install required tools on your host machine

### Ansible & openssh-server

- On Debian based distributions:
  ```sh
  sudo apt --fix-broken install
  sudo apt-get install openssh-server ansible -y
  sudo systemctl enable ssh.service && sudo systemctl start ssh.service
  sudo systemctl enable sshd.service && sudo systemctl start sshd.service
  ```

- On Mac:
  - Install with:
  ```sh
  brew install ansible
  ```
  - Go to System Preferences -> Sharing, enable Remote Login. (for ssh server)

### Docker and Docker-compose (on both, host and server)
- One-time command suggested:
    ```sh
    sudo apt update;\
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common;\
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;\
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable";\
    sudo apt update;\
    sudo apt install -y docker-ce;\
    sudo apt install -y docker-compose;\
    sudo usermod -aG docker $USER
    ```

## Server preparation and files

1. Configure `ops` user as described [here](../subsocial-parachain/README.md#create-a-user-with-sudo-permission).
   1. Paste your SSH public key to the `ops` authorized keys:
      ```sh
      mkdir .ssh; \
      touch .ssh/authorized_keys; \
      chmod 700 .ssh;\
      chmod 600 .ssh/authorized_keys; \
      nano .ssh/authorized_keys
      # Paste in the opened file and save.
      ```
   2. Copy the contents of [subsocial-parachain](../subsocial-parachain) directory into your `ops` user home path:
      ```sh
      # On host machine:
      zip -r pc.zip subsocial-parachain
      scp pc.zip ops@<your_ip>:/home/ops

      # On your remote:
      unzip pc.zip && rm pc.zip
      cp -a subsocial-parachain/. . && rm -rf subsocial-parachain/
      ```
   3. **Don't forget** to additionally configure docker for your `ops` user:
      ```sh
      sudo usermod -aG docker ops
      sudo ln -s /usr/bin/docker-compose /usr/local/bin/docker-compose
      sudo service restart docker
      ```

2. _Optionally_, connect to your server and [prepare the Kusama snapshot](../subsocial-parachain/README.md#optional-prepare-the-kusama-network-snapshot).

### Ansible Instructions

1. Change the IP address under `[collator]` tag in the [inventory](./inventory) file.
2. Run the [collator-playbook.sh](./collator-playbook.sh) in root of the [parachain-ansible-playbook](.) directory to run/update collator.

### Inserting keys

After Ansible process you must login as `ops` user and import your keys.

1. Put needed keys in `aura.json` in the `data` directory.
2. Execute script: `./insert-keys.sh`
3. Remove the `aura.json` file
4. Run `docker exec -it subsocial-collator rm -rf /bin/*` (better not to do before parachain is producing blocks)
    - This will remove execute permission on container.

