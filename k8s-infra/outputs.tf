output "network_id" {
  value = yandex_vpc_network.k8s-network.id
}

output "subnet-a" {
  value = yandex_vpc_subnet.subnet-a.id
}

output "subnet-b" {
  value = yandex_vpc_subnet.subnet-b.id
}

output "subnet-d" {
  value = yandex_vpc_subnet.subnet-d.id
}

# Output для мастер-ноды (k8s-master)

output "k8s_master_public_ip" {
  description = "Public IP address of the Kubernetes master node"
  value       = yandex_compute_instance.k8s-master.network_interface[0].nat_ip_address
}

output "k8s_master_private_ip" {
  description = "Private IP address of the Kubernetes master node"
  value       = yandex_compute_instance.k8s-master.network_interface[0].ip_address
}

output "k8s_master_instance_id" {
  description = "Instance ID of the Kubernetes master node"
  value       = yandex_compute_instance.k8s-master.id
}

# Output для группы worker-нод (k8s-worker-nodes)

output "k8s_worker_nodes_instance_group_id" {
  description = "Instance group ID of the Kubernetes worker nodes"
  value       = yandex_compute_instance_group.k8s-worker-nodes.id
}

output "k8s_worker_nodes_public_ips" {
  description = "Public IP addresses of the Kubernetes worker nodes"
  value       = [
    for instance in yandex_compute_instance_group.k8s-worker-nodes.instances :
    instance.network_interface.0.nat_ip_address
  ]
}

output "k8s_worker_nodes_private_ips" {
  description = "Private IP addresses of the Kubernetes worker nodes"
  value       = [
    for instance in yandex_compute_instance_group.k8s-worker-nodes.instances :
    instance.network_interface.0.ip_address
  ]
}

# Общие метаданные

output "k8s_worker_nodes_count" {
  description = "Number of Kubernetes worker nodes"
  value       = var.count_vm
}

output "k8s_worker_nodes_zones" {
  description = "Zones where Kubernetes worker nodes are deployed"
  value       = yandex_compute_instance_group.k8s-worker-nodes.allocation_policy[0].zones
}
