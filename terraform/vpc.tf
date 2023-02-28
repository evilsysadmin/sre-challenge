module "gcp-network" {
  source  = "terraform-google-modules/network/google"
  version = "~> 6.0"

  project_id   = var.project_id
  network_name = var.network
  routing_mode = "GLOBAL"


  subnets = [
    {
      subnet_name   = "public-subnet"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-west1"
    },
    {
      subnet_name           = "private-subnet"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
  ]

  secondary_ranges = {
    private-subnet = [
      {
        range_name    = var.ip_range_pods_name
        ip_cidr_range = "192.168.0.0/18"
      },
      {
        range_name    = var.ip_range_services_name
        ip_cidr_range = "192.168.64.0/18"
      },
    ]
  }
}

module "private-service-access" {
  source = "git::https://github.com/terraform-google-modules/terraform-google-sql-db.git//modules/private_service_access"
  # source      = "../../modules/private_service_access"
  project_id  = var.project_id
  vpc_network = module.gcp-network.network_name

  depends_on = [module.gcp-network]
}
