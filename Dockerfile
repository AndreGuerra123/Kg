FROM        gradle:5.3.1-jdk8-alpine

LABEL       MAINTAINER="Andre Guerra <guerraandre@hotmail.com>"
LABEL       KOTLIN_VERSION="1.3.30"
LABEL       GRADLE_VERSION="5.3.1"
LABEL       JDK="8"

ENV         KOTLIN_VERSION=1.3.30
ENV         KOTLIN_HOME=/usr/local/kotlin

RUN         cd  /tmp && \
            wget -q -k "https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip"  && \
            unzip "kotlin-compiler-${KOTLIN_VERSION}.zip" && \
            mkdir -p "${KOTLIN_HOME}" && \
            mv "/tmp/kotlinc/bin" "/tmp/kotlinc/lib" "${KOTLIN_HOME}" && \
            rm ${KOTLIN_HOME}/bin/*.bat && \
            chmod +x ${KOTLIN_HOME}/bin/* && \
            ln -s "${KOTLIN_HOME}/bin/"* "/usr/bin/" && \
            apk del wget ca-certificates curl openssl && \
            rm -rf /tmp/* /var/cache/apk/*


RUN         rm -f /var/cache/apk/*
