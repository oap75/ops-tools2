# Fluent-bit deployment instructions

### Create staging docker network.

```sh
sudo docker network create staging
```

### Add values to the fluent-bit config file 

in [fluent-bit.conf](fluent-bit.conf) file :

1. change `$HOST` to the address of the loki instance 
2. chnage `$PORT`to the port numbr of the loki instance 
3. change `$HOST_NAME` to the host name of the server


### Run the fluennt-bit container 

```sh
sudo docker-compose -f docker-compose.yaml up -d
```
