FROM        gradle:5.3.1-jdk8-alpine

USER        root
RUN         apk add --no-cache bash

ENV         KOTLIN_VERSION="1.3.31"

RUN         wget https://github.com/JetBrains/kotlin/releases/download/v$KOTLIN_VERSION/kotlin-compiler-$KOTLIN_VERSION.zip && \
            unzip kotlin-compiler-$KOTLIN_VERSION.zip && \
            rm kotlin-compiler-$KOTLIN_VERSION.zip && \
            rm -f kotlinc/bin/*.bat
ENV         PATH $PATH:./kotlinc/bin
RUN         kotlinc -version



