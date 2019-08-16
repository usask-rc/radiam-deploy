#!/usr/bin/env bash

# This will populate a local registry with defined versions of the radiam external images.

ES_VERSION=6.8.2
POSTGRES_VERSION=11.2-alpine
MEMCACHED_VERSION=1.5-alpine
NGINX_VERSION=1.15

REGISTRY_ENDPOINT=$(/bin/hostname)

echo -n "Installing elasticsearch image"
docker pull docker.elastic.co/elasticsearch/elasticsearch:$ES_VERSION && \
    docker tag docker.elastic.co/elasticsearch/elasticsearch:$ES_VERSION $REGISTRY_ENDPOINT/elastic && \
    docker push $REGISTRY_ENDPOINT/elastic

echo -n "Installing postgres image"
docker pull postgres:$POSTGRES_VERSION && \
    docker tag postgres:$POSTGRES_VERSION $REGISTRY_ENDPOINT/postgres && \
    docker push $REGISTRY_ENDPOINT/postgres

echo -n "Installing memcached image"
docker pull memcached:$MEMCACHED_VERSION && \
    docker tag memcached:$MEMCACHED_VERSION $REGISTRY_ENDPOINT/memcached && \
    docker push $REGISTRY_ENDPOINT/memcached

echo -n "Installing nginx image"
docker pull nginx:$NGINX_VERSION && \
    docker tag nginx:$NGINX_VERSION $REGISTRY_ENDPOINT/nginx && \
    docker push $REGISTRY_ENDPOINT/nginx
