FROM sjoerdmulder/java7

# Install pwgen and add authorized keys
RUN apt-get install -y pwgen
# Add mongodb repo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
RUN apt-get update

VOLUME ["/data"]

# Install mongodb
RUN apt-get install -y mongodb-org-server

# Install elasticsearch
RUN wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.10.tar.gz
RUN tar xzf elasticsearch-0.90.10.tar.gz && rm elasticsearch-0.90.10.tar.gz
RUN mv elasticsearch-0.90.10 /opt/elasticsearch
RUN useradd -s /bin/false -r -M elasticsearch

# Get graylog2 server
RUN wget https://github.com/Graylog2/graylog2-server/releases/download/0.20.1/graylog2-server-0.20.1.tgz
RUN tar xzf graylog2-server-0.20.1.tgz && rm graylog2-server-0.20.1.tgz
RUN mv graylog2-server-0.20.1 /opt/graylog2-server

RUN useradd -s /bin/false -r -M graylog2

# Setup server config
ADD etc/graylog2.conf /etc/graylog2.conf
RUN sed -i -e "s/password_secret =$/password_secret = $(pwgen -s 96)/" /etc/graylog2.conf
RUN sed -i -e "s/root_password_sha2 =$/root_password_sha2 = $(echo -n admin | sha256sum | awk '{print $1}')/" /etc/graylog2.conf


# Get the web-interface
RUN wget https://github.com/Graylog2/graylog2-web-interface/releases/download/0.20.1/graylog2-web-interface-0.20.1.tgz
RUN tar xzf graylog2-web-interface-0.20.1.tgz && rm graylog2-web-interface-0.20.1.tgz
RUN mv graylog2-web-interface-0.20.1 /opt/graylog2-web-interface

# Setup the web-interface
RUN sed -i -e "s/application.secret=.*$/application.secret=\"$(pwgen -s 96)\"/" /opt/graylog2-web-interface/conf/graylog2-web-interface.conf
RUN sed -i -e "s/graylog2-server.uris=.*$/graylog2-server.uris=\"http:\/\/127.0.0.1:12900\/\"/" /opt/graylog2-web-interface/conf/graylog2-web-interface.conf

# Expose ports
#   - 9000: Web interface
#   - 12201: GELF UDP
#   - 12900: REST API
EXPOSE 9000 12201/udp 12900

ADD service /etc/service
