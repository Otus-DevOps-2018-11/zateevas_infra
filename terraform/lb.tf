resource "google_compute_instance_group" "reddit-app-group" {
  name        = "reddit-app-group"
  description = "Reddit-app instance group"
  project = "${var.project}"
  zone = "${var.zone}"
  instances = [
    "${google_compute_instance.app.*.self_link}"
  ]
}
resource "google_compute_health_check" "reddit-app-check" {
  name               = "reddit-app-check"
  check_interval_sec = 1
  timeout_sec        = 1
  http_health_check  {
	port = "9292"
}
}
resource "google_compute_backend_service" "reddit-app-backend" {
  name        = "reddit-app-backend"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10

  backend {
    group = "${google_compute_instance_group.reddit-app-group.self_link}"
  }
	health_checks = ["${google_compute_health_check.reddit-app-check.self_link}"]

}
resource "google_compute_global_forwarding_rule" "reddit-forwarding-rule" {
  name       = "reddit-forwarding-rule"
  target     = "${google_compute_target_http_proxy.reddit-http-proxy.self_link}"
  port_range = "80"
}

resource "google_compute_target_http_proxy" "reddit-http-proxy" {
  name        = "reddit-http-proxy"
  description = "a description"
  url_map     = "${google_compute_url_map.reddit-url-map.self_link}"
}

resource "google_compute_url_map" "reddit-url-map" {
  name            = "url-map"
  description     = "a description"
  default_service = "${google_compute_backend_service.reddit-app-backend.self_link}"

  }
