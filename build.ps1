#pre-req: https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart

Set-Location .\terraform

terraform init

terraform apply -target module.registry -var="folder-id=$Env:YC_FOLDER_ID" -var="service-account-id=$Env:YC_SA_ID"

./docker_build

terraform apply -target module.infr -var="folder-id=$Env:YC_FOLDER_ID" -var="service-account-id=$Env:YC_SA_ID"