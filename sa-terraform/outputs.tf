# output "bucket_service_account_id" {
#   value = yandex_iam_service_account.sa-bucket.id
# }

# output "static_access_key_for_bucket_id" {
#   value = yandex_iam_service_account_static_access_key.sa-bucket-static-key.id
# }

output "terraform_service_account-id" {
  value = yandex_iam_service_account.sa-terraform.id
}

output "static_access_key_for_Terraform_id" {
  value = yandex_iam_service_account_static_access_key.sa-terraform-static-key.id
}

# output "access_key" {
#   value     = yandex_iam_service_account_static_access_key.sa-terraform-static-key.access_key
#   sensitive = true
# }

# output "secret_key" {
#   value     = yandex_iam_service_account_static_access_key.sa-terraform-static-key.secret_key
#   sensitive = true
# }
