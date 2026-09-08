output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.this.public_ip
}

output "ssh_command" {
  description = "Command to SSH into the instance"
  value       = "ssh -i ${var.instance_name}-key.pem ec2-user@${aws_instance.this.public_ip}"
}

output "public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.this.public_dns
}

output "web_url" {
  description = "URL of the nginx default page (via public DNS)"
  value       = "http://${aws_instance.this.public_dns}"
}
