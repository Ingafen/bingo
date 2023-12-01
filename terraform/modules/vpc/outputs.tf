output "db-address" {
  value = yandex_compute_instance.db.network_interface.0.ip_address
}

output "docker-compose" {
  value = yandex_compute_instance.bingo-1.metadata["docker-compose"]
}