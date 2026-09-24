resource "oci_core_vcn" "tf_vcn" {
  compartment_id = var.compartment_ocid
  cidr_block     = "10.1.0.0/16"
  display_name   = "tf-vcn"
  dns_label      = "tfvcn"
}

resource "oci_core_internet_gateway" "tf_igw" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.tf_vcn.id
  display_name   = "tf-igw"
}

resource "oci_core_route_table" "tf_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.tf_vcn.id
  display_name   = "tf-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.tf_igw.id
  }
}

resource "oci_core_security_list" "tf_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.tf_vcn.id
  display_name   = "tf-security-list"

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "6"
    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "6"
    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "6"
    tcp_options {
      min = 8080
      max = 8080
    }
  }
}

resource "oci_core_subnet" "tf_subnet" {
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.tf_vcn.id
  cidr_block                 = "10.1.20.0/24"
  display_name               = "tf-public-subnet"
  dns_label                  = "tfsubnet"
  route_table_id             = oci_core_route_table.tf_route_table.id
  security_list_ids          = [oci_core_security_list.tf_security_list.id]
  prohibit_public_ip_on_vnic = false
}
