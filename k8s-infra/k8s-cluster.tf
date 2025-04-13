# Создание мастер-ноды

resource "yandex_compute_instance" "k8s-master" {
  name = "k8s-master"
  zone = var.default_zone
  platform_id = var.vm_platform
  allow_stopping_for_update = true

  resources {
    cores         = var.k8s-master.vm.cores
    memory        = var.k8s-master.vm.memory
    core_fraction = var.k8s-master.vm.core_fraction
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-a.id
    nat       = true
  }

  boot_disk {
    initialize_params {
      image_id = "fd8pfd17g205ujpmpb0a" # Ubuntu 24.04 LTS
      size     = 30
      type = "network-hdd"
    }
  }

  scheduling_policy {
    preemptible = false
  }

  metadata = {
    # serial-port-enable = 1
    ssh-keys = "ubuntu:${local.ssh-keys}"
    user-data = <<-EOF
      #cloud-config
      package_update: true
      package_upgrade: true
      EOF
  }
}

# Создание worker-нод

resource "yandex_compute_instance_group" "k8s-worker-nodes" {
  name                = "k8s-worker-nodes"
  folder_id           = var.YC_FOLDER_ID
  service_account_id  = var.service_account_id
  deletion_protection = false

  instance_template {
    name        = "k8s-worker-node-{instance.index}"
    platform_id = var.vm_platform

    resources {
      cores         = var.k8s-worker-nodes.vm.cores
      memory        = var.k8s-worker-nodes.vm.memory
      core_fraction = var.k8s-worker-nodes.vm.core_fraction
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd8pfd17g205ujpmpb0a" # Ubuntu 24.04 LTS
        size     = 20
      }
    }

    network_interface {
      network_id = yandex_vpc_network.k8s-network.id
      subnet_ids = [
        yandex_vpc_subnet.subnet-b.id,
        yandex_vpc_subnet.subnet-d.id
      ]
      nat = true
    }

    labels = {
      company = var.company
      dev = var.dev
    }

    metadata = {
    # serial-port-enable = 1
    ssh-keys = "ubuntu:${local.ssh-keys}"
    user-data = <<-EOF
      #cloud-config
      package_update: true
      package_upgrade: true
      EOF
    }

    scheduling_policy {
      preemptible = false
    }
  }

  scale_policy {
    fixed_scale {
      size = var.count_vm
    }
  }

  allocation_policy {
    zones = [
      var.zone_b,
      var.zone_d
    ]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 1
    max_creating = 2
    max_deleting = 2
  }
}
