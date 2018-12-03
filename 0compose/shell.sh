#!/bin/bash

CONTAINER_NAME=0compose_k8s_1

COLUMNS=129
LINES=35

#SHELL=bash
SHELL=zsh

# Check container exists
docker ps -a | awk '{print $NF}' | grep ${CONTAINER_NAME} &>/dev/null

if [[ $? != 0 ]]; then
    echo "You need to create docker container first"
    echo "Using: docker-compose up -d"
else
    # Check container is running
    docker ps | awk '{print $NF}' | grep ${CONTAINER_NAME} &>/dev/null

    if [[ $? != 0 ]]; then
        echo "Start ${CONTAINER_NAME}"
        docker start ${CONTAINER_NAME}
    fi

    docker exec -it ${CONTAINER_NAME} ${SHELL} -c "stty cols $COLUMNS rows $LINES && ${SHELL}";
fi
