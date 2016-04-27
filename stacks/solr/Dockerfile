FROM    solr:latest

EXPOSE 8983

ENV ZOOKEEPER_HOSTS="127.0.0.1:2181"

ENTRYPOINT ["sh", "-c", "/opt/solr/bin/solr start -f -c -z $ZOOKEEPER_HOSTS"]
CMD [""]
