# ВМ с публичным IP

resource "yandex_compute_instance" "public_instance" {
  name = "public-vm-${count.index + 1}"
  zone = var.default_zone
  platform_id = var.vm_platform
  count = 1

  resources {
    cores         = var.vms_resources.vm.cores
    memory        = var.vms_resources.vm.memory
    core_fraction = var.vms_resources.vm.core_fraction
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-a.id
    nat       = true
  }

  boot_disk {
    initialize_params {
      image_id = "fd8pfd17g205ujpmpb0a" # Ubuntu 24.04 LTS
      size     = 10
      type = "network-hdd"
    }
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:${local.ssh-keys}"
  }
}
