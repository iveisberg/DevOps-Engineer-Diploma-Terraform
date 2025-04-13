### cloud vars

variable "service_account_key_file" {
  type        = string
  description = "Path to key json file"
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

### bucket creds

variable "bucket_access_key" {
  type        = string
  description = "Access key for Yandex Cloud Object Storage"
}

variable "bucket_secret_key" {
  type        = string
  description = "Secret key for Yandex Cloud Object Storage"
}
