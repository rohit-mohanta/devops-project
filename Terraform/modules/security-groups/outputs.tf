output "bastion_host_SG_id" {
  value = aws_security_group.bastion_host_SG.id
}

output "private_instances_SG_id" {
  value = aws_security_group.private_instances_SG.id
}

output "public_web_SG_id" {
  value = aws_security_group.public_web_SG.id
}