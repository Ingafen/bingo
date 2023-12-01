#cloud-config

packages:
  - vim
  - curl
  - mc
  - iptables
  - nginx

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
    - sudo mkdir /etc/ssl/direbo
    - |
      sudo cat <<EOT >> /etc/ssl/direbo/direbo.crt
      ${direbocrt}
      EOT
    - |
      sudo cat <<EOT >> /etc/ssl/direbo/direbo.key
      ${direbokey}
      EOT
    - |
      sudo cat <<EOT >> /etc/nginx/nginx.conf
      ${nginxconf}
      EOT       
    - sudo nginx -s reload 