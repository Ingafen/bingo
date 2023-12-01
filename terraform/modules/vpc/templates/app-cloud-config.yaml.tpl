#cloud-config

packages:
  - vim
  - curl
  - mc
  - iptables

runcmd:
  # SETUP MOUNT
    - sudo mkdir /opt/bingo
    - |
      sudo cat <<EOT >> /opt/bingo/config.yaml
      student_email: ${mail}
      postgres_cluster:
        hosts:
        - address: ${db-address}
          port: 5432
        user: ${db-user-name}
        password: ${db-user-password}
        db_name: ${db-name}
        ssl_mode: disable
        use_closest_node: false
      EOT
    - sudo chmod -R 777 /opt/bingo
    - sudo iptables -t nat -A OUTPUT -p tcp -d 8.8.8.8 --dport 80 -j DNAT --to-destination 8.8.8.8:443
    - sudo iptables -t nat -A OUTPUT -p udp -d 8.8.8.8 --dport 80 -j DNAT --to-destination 8.8.8.8:443
    - |
      sudo cat <<EOT >> /opt/bingo/docker+compose1.yaml
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
            source: /opt/bingo/
            target: /opt/bingo
      EOT