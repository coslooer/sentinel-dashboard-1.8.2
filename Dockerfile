FROM openjdk:8-jdk-alpine

ARG SENTINEL_VERSION="1.8.2"

WORKDIR /home/sentinel

RUN adduser -S sentinel && \
    apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" >  /etc/timezone && \
    rm -rf /var/cache/apk/* && \
    sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories
COPY sentinel-dashboard-1.8.2.jar /home/sentinel/sentinel-dashboard.jar
USER sentinel

EXPOSE 8080
CMD java ${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom  -Dserver.port=8080 -Dcsp.sentinel.dashboard.server=localhost:8080 -Dproject.name=sentinel-dashboard -jar "/home/sentinel/sentinel-dashboard.jar"
