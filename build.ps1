Set-Location .\terraform
terraform apply -target module.registry
./docker_build