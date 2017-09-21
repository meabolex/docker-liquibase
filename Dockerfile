FROM openjdk:8-jre-slim

MAINTAINER mark.mixson@ossys.com

COPY lib/liquibase-3.5.3-bin.tar.gz /tmp/liquibase-3.5.3-bin.tar.gz

RUN mkdir /opt/liquibase

RUN tar -xzf /tmp/liquibase-3.5.3-bin.tar.gz -C /opt/liquibase
RUN chmod +x /opt/liquibase/liquibase

RUN ln -s /opt/liquibase/liquibase /usr/local/bin/

COPY lib/mariadb-java-client-2.1.0.jar /opt/jdbc_drivers/

RUN ln -s /opt/jdbc_drivers/mariadb-java-client-2.1.0.jar /usr/local/bin/

ADD scripts /scripts
RUN chmod -R +x /scripts

VOLUME ["/changelogs"]

WORKDIR /

ENTRYPOINT ["/bin/bash"]
