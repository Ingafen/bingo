FROM ubuntu:latest as build 
WORKDIR /build-app

RUN apt-get update && apt-get install curl -y 
RUN curl -O https://storage.yandexcloud.net/final-homework/bingo


FROM alpine:latest as release
WORKDIR /app

COPY --from=build /build-app . 

RUN mkdir /opt/bingo && \
    mkdir /opt/bongo && \
    mkdir /opt/bongo/logs && \ 
    mkdir /opt/bongo/logs/577d315fe5 && \
    touch /opt/bongo/logs/577d315fe5/main.log

EXPOSE 12237

CMD ["bingo", "run_server"]