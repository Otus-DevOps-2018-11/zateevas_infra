output "db_address" {
  value = "${google_compute_instance.db.network_interface.0.address}"
}
