FROM        gradle:5.3.1-jdk8-alpine

LABEL       MAINTAINER="Andre Guerra <guerraandre@hotmail.com>"
LABEL       KOTLIN_VERSION="1.3.30"
LABEL       GRADLE_VERSION="5.3.1"
LABEL       ARANGODB_VERSION="3.4.4"
LABEL       JDK="8"

//Adds Kotlin
RUN         wget https://github.com/JetBrains/kotlin/releases/download/v1.3.30/kotlin-compiler-1.3.30.zip && \
            unzip kotlin-compiler-*.zip && \
            rm kotlin-compiler-*.zip && \
            rm -f kotlinc/bin/*.bat
ENV         PATH $PATH:./kotlinc/bin

// Adds ArangoDB
ENV ARANGO_VERSION 3.4.4
ENV ARANGO_URL https://download.arangodb.com/arangodb34/DEBIAN/amd64
ENV ARANGO_PACKAGE arangodb3_${ARANGO_VERSION}-1_amd64.deb
ENV ARANGO_PACKAGE_URL ${ARANGO_URL}/${ARANGO_PACKAGE}
ENV ARANGO_SIGNATURE_URL ${ARANGO_PACKAGE_URL}.asc

RUN apk add --no-cache gnupg pwgen nodejs npm binutils && \
    npm install -g foxx-cli && \
    rm -rf /root/.npm

RUN gpg --batch --keyserver hkps://hkps.pool.sks-keyservers.net --recv-keys CD8CB0F1E0AD5B52E93F41E7EA93F5E56E751E9B

RUN mkdir /docker-entrypoint-initdb.d

RUN cd /tmp                                && \
    wget ${ARANGO_SIGNATURE_URL}           && \
    wget ${ARANGO_PACKAGE_URL}             && \
    gpg --verify ${ARANGO_PACKAGE}.asc     && \
    ar x ${ARANGO_PACKAGE} data.tar.gz     && \
    tar -C / -x -z -f data.tar.gz          && \
    sed -ri \
        -e 's!127\.0\.0\.1!0.0.0.0!g' \
        -e 's!^(file\s*=\s*).*!\1 -!' \
        -e 's!^\s*uid\s*=.*!!' \
        /etc/arangodb3/arangod.conf        && \
    echo chgrp 0 /var/lib/arangodb3 /var/lib/arangodb3-apps && \
    echo chmod 775 /var/lib/arangodb3 /var/lib/arangodb3-apps && \
    rm -f /usr/bin/foxx && \
    rm -f ${ARANGO_PACKAGE}* data.tar.gz
    
VOLUME ["/var/lib/arangodb3", "/var/lib/arangodb3-apps"]

COPY docker-entrypoint.sh /entrypoint.sh
copy docker-foxx.sh /usr/bin/foxx

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8529
CMD ["arangod"]
