graylog2-docker
===============

Debian-based, self-contained graylog2 image. Can run standalone or backed by an existing elasticsearch cluter. 



## Using It

The username/password is admin/admin.


## Enviornment Variables

* ``ES_CLUSTER_NAME`` - the name of the elasticsearch cluster this graylog2 instance should join
* ``ES_CLUSTER_HOSTS`` - comma separated string of host/port combinations that graylog2 should attempt to connect to. This will get plugged into ``elasticsearch_discovery_zen_ping_unicast_hosts`` in the graylog2.conf
* ``CORS_ENABLED`` - Enable CORS
