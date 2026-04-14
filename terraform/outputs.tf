output "public_ip" {
  description = "Public IP of the Kubernetes node"
  value       = data.aws_eip.eip.public_ip
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.k8s_node.id
}

output "instance_name" {
  description = "EC2 instance name"
  value       = var.instance_name
}

output "ssh_command" {
  description = "SSH command to connect"
  value       = "ssh -i <your-key>.pem ubuntu@${data.aws_eip.eip.public_ip}"
}