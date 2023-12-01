version: '3.7'
services:
  bingo:
    container_name: bingo
    image: "cr.yandex/${cr-id}/${app-name}:latest"
    restart: always
    ports: 
    - "80:12337"
    volumes:
    - type: bind
      source: ${host-dir-with-app-conf}
      target: /opt/bingo