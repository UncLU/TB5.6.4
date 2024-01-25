# target group 

resource "yandex_lb_target_group" "nginx" {
  name = "target-nginx"
  target {
    subnet_id = yandex_vpc_subnet.suba.id
    address   = module.ya_instance_1.internal_ip_address_vm
  }
  target {
    subnet_id = yandex_vpc_subnet.subb.id
    address   = module.ya_instance_2.internal_ip_address_vm
  }
}

resource "yandex_lb_network_load_balancer" "lb-test" {
  name                = "lb-test"
  deletion_protection = "false"
  listener {
    name = "lisner"
    port = 8080
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.nginx.id
    healthcheck {
      name = "http"
      http_options {
        port = 8080
        #        path = "/ping"
      }
    }
  }
}

