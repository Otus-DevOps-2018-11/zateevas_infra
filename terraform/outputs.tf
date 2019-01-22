output "app_0_external_ip" {
  value = "${google_compute_instance.app.0.network_interface.0.access_config.0.assigned_nat_ip}"
}

output "app_1_external_ip" {
  value = "${google_compute_instance.app.1.network_interface.0.access_config.0.assigned_nat_ip}"
}

output "lb_external_ip" {
  value = "${google_compute_global_forwarding_rule.reddit-forwarding-rule.ip_address}"
}
