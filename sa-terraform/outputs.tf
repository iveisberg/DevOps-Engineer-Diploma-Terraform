output "terraform_service_account-id" {
  value = yandex_iam_service_account.sa-terraform.id
}

output "static_access_key_for_Terraform_id" {
  value = yandex_iam_service_account_static_access_key.sa-terraform-static-key.id
}
