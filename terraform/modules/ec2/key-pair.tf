resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "instance" {
  key_name   = "${var.key_name}"
  public_key = "${tls_private_key.ssh_key.public_key_openssh}"
  tags ={
        Name = "${var.basename}"
  }
}

resource "local_file" "private_key" {
    content  = tls_private_key.ssh_key.private_key_pem
    filename = "${var.key_name}.pem"
}

resource "local_file" "public_key" {
    content  = tls_private_key.ssh_key.public_key_openssh
    filename = "${var.key_name}.pub"
}
