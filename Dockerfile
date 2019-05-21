FROM        gradle:5.3.1-jdk8-alpine

USER root

LABEL       MAINTAINER="Andre Guerra <guerraandre@hotmail.com>"
LABEL       KOTLIN_VERSION="1.3.30"
LABEL       GRADLE_VERSION="5.3.1"
LABEL       ARANGODB_VERSION="3.4.4"
LABEL       JDK="8"

# Installing Kotlin
RUN         wget https://github.com/JetBrains/kotlin/releases/download/v1.3.30/kotlin-compiler-1.3.30.zip && \
            unzip kotlin-compiler-*.zip && \
            rm kotlin-compiler-*.zip && \
            rm -f kotlinc/bin/*.bat
ENV         PATH $PATH:./kotlinc/bin

# Installing ArangoDB
RUN         apk add --no-cache git-core build-essential libssl-dev libjemalloc-dev cmake libldap2-dev



# EXPOSE 8529
# CMD ["arangod start"]

