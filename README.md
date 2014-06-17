graylog2-docker
===============

Debian-based, self-contained graylog2 image. Can run standalone or backed by an existing elasticsearch cluter. 



## Using It

To get started quickly with an embedded elasticsearch instance, do this:

```bash

docker run -d -p 9000:9000 -p 514:514 -p 12201:12201 lukecyca/graylog2-docker
```

To get it rolling with an existing elasticsearch cluster

```bash

docker run -d -p 9000:9000 -p 514:514 -p 12201:12201 -e ES_CLUSTER_NAME=<cluster_name> -e ES_CLUSTER_HOSTS=cluster01:9300,cluster02:9300 lukecyca/graylog2-docker

```

The username/password to the web interface is admin/admin.


## Environment Variables

* ``ES_CLUSTER_NAME`` - the name of the elasticsearch cluster this graylog2 instance should join
* ``ES_CLUSTER_HOSTS`` - comma separated string of host/port combinations that graylog2 should attempt to connect to. This will get plugged into ``elasticsearch_discovery_zen_ping_unicast_hosts`` in the graylog2.conf
* ``CORS_ENABLED`` - Enable CORS
