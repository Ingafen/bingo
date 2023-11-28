#pre-req: https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart

Set-Location .\terraform

terraform init

terraform apply -target module.registry

./docker_build