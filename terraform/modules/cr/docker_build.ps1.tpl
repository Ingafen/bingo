docker build -f ../docker/Dockerfile -t cr.yandex/${cr-id}/${app-name}:latest --no-cache ../docker
docker login --username iam --password $Env:YC_TOKEN cr.yandex
docker push cr.yandex/${cr-id}/${app-name}:latest