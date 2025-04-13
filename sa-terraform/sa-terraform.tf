# Сервис-аккаунт для Terraform с необходимыми правами

resource "yandex_iam_service_account" "sa-terraform" {
  name        = "terraform-service-account"
  folder_id   = var.YC_FOLDER_ID
  description = "Service account for Terraform"
}

# Добавляем роли для сервисного аккаунта

resource "yandex_resourcemanager_folder_iam_member" "sa-terraform-editor" {
  folder_id = var.YC_FOLDER_ID
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa-terraform.id}"
  depends_on = [
    yandex_iam_service_account.sa-terraform,
  ]
}

# resource "yandex_resourcemanager_folder_iam_member" "sa-terraform-storage-editor" {
#   folder_id = var.YC_FOLDER_ID
#   role      = "storage.editor"
#   member    = "serviceAccount:${yandex_iam_service_account.sa-terraform.id}"
#   depends_on = [
#     yandex_iam_service_account.sa-terraform,
#   ]
# }

# resource "yandex_resourcemanager_folder_iam_member" "sa-terraform-kms-keys" {
#   folder_id = var.YC_FOLDER_ID
#   role      = "kms.keys.encrypterDecrypter"
#   member    = "serviceAccount:${yandex_iam_service_account.sa-terraform.id}"
#   depends_on = [
#     yandex_iam_service_account.sa-terraform,
#   ]
# }

# resource "yandex_resourcemanager_folder_iam_member" "sa-terraform-pusher" {
#   folder_id = var.YC_FOLDER_ID
#   role      = "container-registry.images.pusher"
#   member    = "serviceAccount:${yandex_iam_service_account.sa-terraform.id}"
#   depends_on = [
#     yandex_iam_service_account.sa-terraform,
#   ]
# }

# resource "yandex_resourcemanager_folder_iam_member" "sa-terraform-puller" {
#   folder_id = var.YC_FOLDER_ID
#   role      = "container-registry.images.puller"
#   member    = "serviceAccount:${yandex_iam_service_account.sa-terraform.id}"
#   depends_on = [
#     yandex_iam_service_account.sa-terraform,
#   ]
# }

# Создаем ключи для сервисного аккаунта

resource "yandex_iam_service_account_static_access_key" "sa-terraform-static-key" {
  service_account_id = yandex_iam_service_account.sa-terraform.id
  description        = "Static access key for Terraform"
  depends_on = [
    yandex_iam_service_account.sa-terraform,
  ]
}

resource "local_file" "secret-backend-tfvars" {
  content = <<EOT
    access_key = "${yandex_iam_service_account_static_access_key.sa-terraform-static-key.access_key}"
    secret_key = "${yandex_iam_service_account_static_access_key.sa-terraform-static-key.secret_key}"
  EOT

  filename = "output_file/secret.backend.tfvars"

  depends_on = [
    yandex_iam_service_account_static_access_key.sa-terraform-static-key,
  ]
}

resource "yandex_iam_service_account_key" "sa-terraform-key" {
  service_account_id = yandex_iam_service_account.sa-terraform.id
  description        = "Authority key"
  key_algorithm      = "RSA_2048"
}

resource "local_file" "service-account-key" {
  content = jsonencode({
    id                 = yandex_iam_service_account_key.sa-terraform-key.id
    service_account_id = yandex_iam_service_account_key.sa-terraform-key.service_account_id
    created_at         = yandex_iam_service_account_key.sa-terraform-key.created_at
    key_algorithm      = yandex_iam_service_account_key.sa-terraform-key.key_algorithm
    private_key        = yandex_iam_service_account_key.sa-terraform-key.private_key
    public_key         = yandex_iam_service_account_key.sa-terraform-key.public_key
  })

  filename = "output_file/sa-key.json"

  depends_on = [
    yandex_iam_service_account.sa-terraform,
    yandex_iam_service_account_key.sa-terraform-key,
  ]
}
