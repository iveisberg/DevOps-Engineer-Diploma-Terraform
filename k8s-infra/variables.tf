### cloud vars

variable "service_account_key_file" {
  type        = string
  description = "Path to key json file"
}

variable "service_account_id" {
  default     = "ajeo5i3oec2rcqedgau0"
  description = "service_account_id"
}

variable "ssh_public_key" {
  type        = string
  description = "Location of SSH public key."
}

variable "YC_CLOUD_ID" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "YC_FOLDER_ID" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_region" {
  type        = string
  default     = "ru-central1"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

# Создаем VPC

variable "vpc_name" {
  type        = string
  default     = "k8s-network"
  description = "VPC network"
}

# Создаем подсеть

variable "vpc_subnet_name_a" {
  type        = string
  default     = "subnet-a"
  description = "VPC network&subnet name"
}

variable "zone_a" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "cidr_zone_a" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

# Дополнительные подсети

variable "vpc_subnet_name_b" {
  type        = string
  default     = "subnet-b"
  description = "VPC network&subnet name"
}

variable "zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "cidr_zone_b" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_subnet_name_d" {
  type        = string
  default     = "subnet-d"
  description = "VPC network&subnet name"
}

variable "zone_d" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "cidr_zone_d" {
  type        = list(string)
  default     = ["10.0.3.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

### cloud machines ###

variable "company" {
  type    = string
  default = "netology"
}

variable "dev" {
  type    = string
  default = "diploma"
}

variable "vm_platform" {
  type        = string
  default     = "standard-v2"
}

variable "count_vm" {
  type        = number
  default     = 2
}

variable "k8s-master" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    disk_volume   = number
    disk_type     = string
  }))
  default = {
    vm = {
      cores = 2,
      memory = 4,
      disk_volume = 30,
      disk_type = "network-hdd",
      core_fraction = 5
    }
  }
  description = "Resource for VM k8s-master"
}

variable "k8s-worker-nodes" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    disk_volume   = number
    disk_type     = string
  }))
  default = {
    vm = {
      cores = 2,
      memory = 4,
      disk_volume = 20,
      disk_type = "network-hdd",
      core_fraction = 5
    }
  }
  description = "Resource for VMs"
}
