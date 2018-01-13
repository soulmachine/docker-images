## Run a cluster with a single ElasticSearch node and a Kibana node

    docker-compose -f docker-compose-single-elasticsearch-node.yml up


## Run a cluster with two ElasticSearch nodes and a Kibana node

    docker-compose -f docker-compose-two-elasticsearch-nodes.yml up


## Backup a named volume's data

    docker volume ls
    docker run -it --rm -v volume_name:/volume -v $(pwd):/backup ubuntu:latest tar -zcvf /backup/file_name.tar.gz /volume


## Restore a named volume's data

    docker run -it --rm -v volume_name:/volume -v $(pwd):/backup ubuntu:latest sh -c "rm -rf /volume/*; tar -zxvf /backup/file_name.tar.gz -C /volume/"

