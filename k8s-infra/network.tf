# Создаем VPC

resource "yandex_vpc_network" "k8s-network" {
  name = var.vpc_name
}

# Создаем шлюз

resource "yandex_vpc_gateway" "nat_gateway" {
  folder_id = var.YC_FOLDER_ID
  name      = "gateway"
  shared_egress_gateway {}
}

# Создаем таблицу маршрутизации

resource "yandex_vpc_route_table" "nat_route_table" {
  folder_id = var.YC_FOLDER_ID
  name = "nat_route_table"
  network_id = yandex_vpc_network.k8s-network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

# Создаем подсети за NAT

resource "yandex_vpc_subnet" "subnet-a" {
  name           = var.vpc_subnet_name_a
  zone           = var.zone_a
  network_id     = yandex_vpc_network.k8s-network.id
  v4_cidr_blocks = var.cidr_zone_a
  route_table_id = yandex_vpc_route_table.nat_route_table.id
  depends_on = [
    yandex_vpc_route_table.nat_route_table
  ]
}

# Дополнительные подсети

resource "yandex_vpc_subnet" "subnet-b" {
  name           = var.vpc_subnet_name_b
  zone           = var.zone_b
  network_id     = yandex_vpc_network.k8s-network.id
  v4_cidr_blocks = var.cidr_zone_b
  route_table_id = yandex_vpc_route_table.nat_route_table.id
  depends_on = [
    yandex_vpc_route_table.nat_route_table
  ]
}

resource "yandex_vpc_subnet" "subnet-d" {
  name           = var.vpc_subnet_name_d
  zone           = var.zone_d
  network_id     = yandex_vpc_network.k8s-network.id
  v4_cidr_blocks = var.cidr_zone_d
  route_table_id = yandex_vpc_route_table.nat_route_table.id
  depends_on = [
    yandex_vpc_route_table.nat_route_table
  ]
}
