FROM        gradle:5.3.1-jdk8-alpine

LABEL       MAINTAINER="Andre Guerra <guerraandre@hotmail.com>"
LABEL       KOTLIN_VERSION="1.3.30"
LABEL       GRADLE_VERSION="5.3.1"
LABEL       JDK="8"

RUN         sudo -i

RUN         cd /usr/lib && \
            wget https://github.com/JetBrains/kotlin/releases/download/v1.3.30/kotlin-compiler-1.3.30.zip && \
            unzip kotlin-compiler-*.zip && \
            rm kotlin-compiler-*.zip && \
            rm -f kotlinc/bin/*.bat

ENV         PATH $PATH:/usr/lib/kotlinc/bin

CMD         ["kotlinc"]

