# monitoring deployment instructions

### Create nodes_network docker network.

```sh
sudo docker network create nodes_network
```

### Open the monitoring port on the server for prometheus instance

1. open `9200` for the Node_Exporter
2. open `8080`for the CAdvisor


### Run the monitoring containers

```sh
sudo docker-compose -f docker-compose.yaml up -d
```
