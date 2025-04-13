terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 1.5"
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id  = var.YC_CLOUD_ID
  folder_id = var.YC_FOLDER_ID
  zone      = var.default_zone
}
