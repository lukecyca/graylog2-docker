#!/bin/bash

is_easticsearch_cluster_defined() {
  [[ -n "$ES_CLUSTER_HOSTS" ]]
}

is_cors_enabled() {
  [[ -n "$CORS_ENABLED" ]]
}

enable_cluster_in_graylog() {
  sed -i -e "s/#elasticsearch_cluster_name = graylog2/elasticsearch_cluster_name = ${ES_CLUSTER_NAME}/" /etc/graylog2.conf
  sed -i -e "s/#elasticsearch_node_master = false/elasticsearch_node_master = false/" /etc/graylog2.conf
  sed -i -e "s/#elasticsearch_node_data = false/elasticsearch_node_data = false/" /etc/graylog2.conf
  sed -i -e "s/elasticsearch_discovery_zen_ping_unicast_hosts = 127.0.0.1:9300/elasticsearch_discovery_zen_ping_unicast_hosts = ${ES_CLUSTER_HOSTS}/" /etc/graylog2.conf
}

dont_start_elasticsearch() {
  sed -i -e "s/autorestart=true ;es/autorestart=false ;es\nautostart=false ;es/" /etc/supervisor/conf.d/supervisord-graylog.conf
}

enable_cors() {
  sed -i -e "s/#rest_enable_cors = true/rest_enable_cors = true/" /etc/graylog2.conf
}


main() {
  is_easticsearch_cluster_defined \
    && enable_cluster_in_graylog \
    && dont_start_elasticsearch
  
  is_cors_enabled \
    && enable_cors

  return 0
}

main
