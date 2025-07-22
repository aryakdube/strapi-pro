output "ec2_public_ip" {
  description = "Public IP of the deployed EC2 instance"
  value       = aws_instance.strapi_ec2.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS of the deployed EC2 instance"
  value       = aws_instance.strapi_ec2.public_dns
}
