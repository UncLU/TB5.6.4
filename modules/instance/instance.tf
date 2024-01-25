terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.105.0"
    }
  }
  required_version = ">=0.105.0"
}

provider "yandex" {
  service_account_key_file = "/home/unclelu/Documents/LearningDevOps/ModuleB5/TaskB5.7/TB5.6.4/sa.json"
# token = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

data "yandex_compute_image" "my_image" {
  family = var.instance_family_image
}

resource "yandex_compute_instance" "vm" {
  name = "terra-${var.instance_family_image}"
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = true
  }

  metadata = {
   #userdata = "${file("~/meta.txt")}"
   ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
