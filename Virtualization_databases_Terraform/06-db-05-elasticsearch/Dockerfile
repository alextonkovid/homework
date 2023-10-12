FROM centos:7

EXPOSE 9200 9300
RUN yum -y update && \
    yum -y install java-1.8.0-openjdk-headless && \
    yum clean all

RUN curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.12.0-linux-x86_64.tar.gz && \
    tar xvf elasticsearch-7.12.0-linux-x86_64.tar.gz && \
    mv elasticsearch-7.12.0 /usr/share/elasticsearch && \
    rm -f elasticsearch-7.12.0-linux-x86_64.tar.gz

COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

RUN mkdir -p /var/lib/elasticsearch && \
    chown -R 1000:1000 /var/lib/elasticsearch
RUN chmod -R 777 /usr/share/elasticsearch

USER 1000

CMD ["/usr/share/elasticsearch/bin/elasticsearch"]
