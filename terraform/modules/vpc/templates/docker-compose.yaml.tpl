version: '3.7'
services:
  catgpt:
    container_name: catgpt
    image: "cr.yandex/${cr-id}/${app-name}:latest"
    restart: always
    network_mode: "host"