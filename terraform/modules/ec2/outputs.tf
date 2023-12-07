output "instance_ids" {
  value       = aws_instance.instance.*.id
  description = "Instance IDs"
}

output "private_key" {
  value = tls_private_key.ssh_key.private_key_pem
}

output "public_key" {
  value = tls_private_key.ssh_key.public_key_openssh
}
