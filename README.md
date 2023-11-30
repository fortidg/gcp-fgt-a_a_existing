# GCP Active/Active dual zone FortiGate POC

## How do you run these?

1. Log into GCP console and open a cloud shell.
1. use `git clone https://github.com/fortidg/gcp-fgt-a_a_existing.git` to clone this repo.
1. Open `terraform.tfvars.example`Change the name to 'terraform.tfvars' update the required variables (project, region, zone zone2, prefix, fortigate_vm_image, fortigate_machine_type)   
1. Run `terraform get`.
1. Run `terraform init`.
1. Run `terraform plan`.
1. If the plan looks good, run `terraform apply`.

The prefix mentioned above is simply a memorable string of text to differentiate the resources deployed by this code.

If you use the Pay As You Go (PAYG) image or if you want to use FortiFlex, leave the Fortigate names in terraform.tfvars set as null.  

If you would like use the Bring Your Own License (BYOL) image, please add the license files in the local directory and modify the names  in terraform.tfvars accordingly.  If you leave the names as null for the BYOL instance, you can manually upload the licenses later or use FortiFlex.  Future versions will allow putting FortiFlex tokens in at bootstrap.  If using FortiFlex, ssh to the fortigates using the public IPs associated with port 1 from the outputs and issue the `execute vm-license <TOKEN>` CLI command.

If you wish to deploy FortGates in only one zone, you can use the same value for "zone" and "zone2".

FortiGates can be managed by putting `https://<fortigate-public-ip>:8443` into the url bar of your favorite browser. These IP addresses will be part of the Terraform outputs upon using apply.


This terraform will use existing customer subnets/networks.  It is assumed that Cloud NAT router and cloud nat are already configured in the "untrust" subnet.  If that is not the case, un-comment those stanzas in the resources.tf file.

This terraform assumes that customer networks already have firewall rules in place.  You will need to update them based on the below link:

https://docs.fortinet.com/document/fortigate/6.4.0/ports-and-protocols/303168/fortigate-open-ports

In addition to those ports, you will need to allow tcp 8008 in both the trust and untrust subnets to allow heartbeat probes for load balancers.

Conversely, if you wish to allow all you can un-comment the firewall stanzas in resources.tf . 