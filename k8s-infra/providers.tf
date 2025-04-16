terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 1.5"

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket     = "ts-bucket"
    region     = "ru-central1"
    key        = "terraform-state/terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # необходимо для Terraform версии 1.6.1 и выше.
    skip_s3_checksum            = true # необходимо при описании бэкенда для Terraform версии 1.6.3 и выше.
  }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id  = var.YC_CLOUD_ID
  folder_id = var.YC_FOLDER_ID
  zone      = var.default_zone
}
