data "google_compute_subnetwork" "compute_subnetwork" {
  for_each = local.subnets
  name = each.value.name  
  region          = var.region
}