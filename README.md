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

The username/password to the web interface is admin/admin. You can
override the password with the ``GRAYLOG2_ADMIN_PASSWORD`` environment
variable.


## Configuration

### Environment Variables

* ``ES_CLUSTER_NAME`` - the name of the elasticsearch cluster this graylog2 instance should join
* ``ES_CLUSTER_HOSTS`` - comma separated string of host/port combinations that graylog2 should attempt to connect to. This will get plugged into ``elasticsearch_discovery_zen_ping_unicast_hosts`` in the graylog2.conf
* ``CORS_ENABLED`` - Enable CORS
* `GRAYLOG2_ES_PLUGINS` - comma separated list of elasticsearch plugins
to include. Will install on first run. (e.g.
``GRAYLOG2_ES_PLUGINS=elasticsearch/elasticsearch-cloud-aws/1.6.0,lmenezes/elasticsearch-kopf/0.9.0``)
* `GRAYLOG2_ADMIN_PASSWORD` - Sets the admin password for graylog2, must
already be sha256 hashed. Do this in a console: ``echo $(echo -n clever | sha256sum | awk '{print $1}')``
* `GRAYLOG2_ADMIN_USER` - Sets the admin password for graylog2

#### Graylog Elasticsearch Configuration
You can also define any number of vairables to tune the definition of
the embedded graylog2 elasticsearch instance as well. These are defined
with the prefix ``gec.`` and written when the elasticsearch
configuration file is generated. 

For example, say we want to enable the http interface, host it on port
9500 and specify the plugin path: 


```bash
-e GEC.HTTP.PORT=9500 -e GEC.HTTP.ENABLED=true -e GEC.PATH.PLUGINS=/opt/graylog2-server/plugins

```

This will generate the following configuration file: 

```yaml
http.enabled: true
http.port: 9500
path.plugins: /opt/graylog2-server/plugins

```
