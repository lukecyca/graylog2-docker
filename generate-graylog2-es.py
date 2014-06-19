#!/usr/bin/env /usr/bin/python

import os
import yaml

ELASTICSEARCH_CONFIG_FILE = os.path.join('/etc', 'graylog2-elasticsearch.yml')

struct = {}
for k, v in os.environ.items():
    k = k.lower()
    if k.startswith('gec.'):
        es_key = k.lower().replace('gec.', '')
        struct[es_key] = int(v) if v.isdigit() else v

if struct:
    with open(ELASTICSEARCH_CONFIG_FILE, 'w+') as conf:
        yaml.dump(struct, conf, default_flow_style=False)

