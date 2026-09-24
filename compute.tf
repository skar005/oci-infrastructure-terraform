resource "oci_core_instance" "tf_instance" {
  compartment_id      = var.compartment_ocid
  availability_domain  = data.oci_identity_availability_domains.ads.availability_domains[0].name
  shape                = "VM.Standard.A1.Flex"
  display_name         = "tf-instance"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 6
  }

  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.uk-london-1.aaaaaaaagghl3ftxsfnrszgcsqy2voqkybm5q5zi7f6h6y452qv5o2txe6eq"
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.tf_subnet.id
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}
