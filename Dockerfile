FROM openjdk:8-jdk-alpine

RUN apk add --no-cache curl bash

ENV ZK_VERSION=3.4.13

RUN mkdir -p /opt \
    && curl -SL http://www.us.apache.org/dist/zookeeper/zookeeper-$ZK_VERSION/zookeeper-$ZK_VERSION.tar.gz | tar xzv -C /opt \
    && mkdir -p /var/lib/zookeeper \
    && ln -s /opt/zookeeper-$ZK_VERSION /opt/zookeeper

COPY entrypoint.sh /
COPY zoo.cfg /opt/zookeeper/conf/

VOLUME ["/var/lib/zookeeper"]
EXPOSE 2181 2888 3888
ENTRYPOINT ["/entrypoint.sh"]
CMD ["run"]
