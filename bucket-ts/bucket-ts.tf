# Создание бакета в Object Storage

resource "yandex_storage_bucket" "ts-bucket" {
  bucket = "ts-bucket"
  access_key = var.bucket_access_key
  secret_key = var.bucket_secret_key
  force_destroy = "true"
  acl = "public-read"    # Делаем бакет не доступным из интернета
  max_size = 1073741824 # 1Gb

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-bucket.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "yandex_kms_symmetric_key" "key-bucket" {
  name              = "encryption-key-bucket"
  description       = "Key for encrypting bucket objects"
  default_algorithm = "AES_256"
  rotation_period   = "8760h" // equal to 1 year
}
