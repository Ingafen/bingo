#cloud-config

packages:
  - postgresql
  - vim
  - curl
  - mc

runcmd:
  # SETUP POSTGRESQL
    - sudo echo "listen_addresses = '*'" >> /etc/postgresql/12/main/postgresql.conf
    - |
        sudo -u postgres psql -U postgres postgres <<SQL
            CREATE USER ${db-user-name} WITH PASSWORD '${db-user-password}';
        SQL
    - |
        sudo -u postgres psql -U postgres postgres <<SQL
            CREATE DATABASE ${db-name};
        SQL
    - |
        sudo -u postgres psql -U postgres postgres <<SQL
            ALTER DATABASE ${db-name} OWNER TO ${db-user-name};
        SQL
    - |
        sudo -u postgres psql -U postgres postgres <<SQL
            GRANT ALL PRIVILEGES ON DATABASE ${db-name} TO ${db-user-name};
        SQL
    - sudo echo "host    ${db-name}    ${db-user-name}    0.0.0.0/0     password" >> /etc/postgresql/12/main/pg_hba.conf
    - sudo service postgresql restart
  # FILL DB
    - sudo mkdir /opt/bingo
    - sudo mkdir /opt/bongo
    - sudo mkdir /opt/bongo/
    - sudo mkdir /opt/bongo/logs
    - sudo mkdir /opt/bongo/logs/577d315fe5
    - |
        sudo cat <<EOT >> /opt/bingo/config.yaml
        student_email: ${mail}
        postgres_cluster:
          hosts:
          - address: localhost
            port: 5432
          user: ${db-user-name}
          password: ${db-user-password}
          db_name: ${db-name}
          ssl_mode: disable
          use_closest_node: false
        EOT
    - sudo chmod -R 777 /opt/bingo   
    - sudo chmod -R 777 /opt/bongo/logs/577d315fe5
    - cd /opt/bingo
    - curl -O https://storage.yandexcloud.net/final-homework/bingo
    - sudo chmod +x bingo    
    - sudo -u postgres ./bingo prepare_db