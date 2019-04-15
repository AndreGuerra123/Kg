FROM        ubuntu:bionic

LABEL       MAINTAINER="Andre Guerra <guerraandre@hotmail.com>"
LABEL       KOTLIN_VERSION="1.3.30"
LABEL       GRADLE_VERSION="5.3.1"
LABEL       JDK="8"


ENV         DEBIAN_FRONTEND noninteractive
ENV         JAVA_HOME       /usr/lib/jvm/java-8-oracle
ENV         LANG            en_US.UTF-8
ENV         LC_ALL          en_US.UTF-8

ENV         KOTLIN_VERSION=1.3.30
ENV         KOTLIN_HOME=/usr/local/kotlin

ENV         GRADLE_VERSION=5.3.1
ENV         GRADLE_HOME=/usr/local/gradle

RUN         apt-get update && \
            apt-get install -y --no-install-recommends locales && \
            locale-gen en_US.UTF-8 && \
            apt-get dist-upgrade -y && \
            apt-get --purge remove openjdk* && \
            echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
            echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list && \
            apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
            apt-get update && \
            apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default && \
            apt-get clean all

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

RUN 

RUN         rm -f /var/cache/apk/*