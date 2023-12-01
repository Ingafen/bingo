FROM ubuntu:latest as build 
WORKDIR /build-app

RUN apt-get update && apt-get install curl wget -y 
RUN curl -O https://storage.yandexcloud.net/final-homework/bingo
RUN chmod +x bingo

FROM alpine:latest as release
ARG username=appuser
ARG groupname=appgroup

RUN mkdir /opt/bingo && \
    mkdir /opt/bongo && \
    mkdir /opt/bongo/logs && \ 
    mkdir /opt/bongo/logs/577d315fe5 && \
    touch /opt/bongo/logs/577d315fe5/main.log

COPY --from=build /usr/bin/wget .
RUN chmod 777 wget

RUN addgroup -S $groupname && adduser -S $username -G $groupname
RUN chown -R $username /opt/bingo && \
    chown -R $username /opt/bongo/logs/577d315fe5     

HEALTHCHECK --interval=30s --timeout=1s CMD wget --no-verbose --tries=1 --spider http://localhost:12337/ping || kill 1

USER $username

WORKDIR /app

COPY --from=build /build-app . 

EXPOSE 12337
 
ENTRYPOINT ["./bingo", "run_server"]