# Define required providers and versions
terraform {
required_providers {
newrelic = {
source = "newrelic/newrelic"
version = "~> 3.0"
}
aws = {
source = "hashicorp/aws"
version = "~> 5.0"
}
}
}
# AWS provider configuration
provider "aws" {
region = "eu-north-1"
}
# New Relic provider configuration
provider "newrelic" {
api_key = var.new_relic_license_key
account_id = var.new_relic_account_id
}
# Security group configuration for the Flask application
resource "aws_security_group" "flask_sg" {
name = "flask_sg"
description = "Allow inbound traffic on port 5003 and SSH (port 22)"
ingress {
from_port = 5003
to_port = 5003
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}
# EC2 instance configuration for deploying Flask app
resource "aws_instance" "flask_app" {
ami = "ami-089146c5626baa6bf"
instance_type = "t3.micro"
key_name = var.key_name
security_groups = [aws_security_group.flask_sg.name]
tags = {
Name = "FlaskApp"
}
user_data = <<-EOF
#!/bin/bash
apt-get update -y
apt-get install -y python3-pip python3-dev
pip3 install flask newrelic
echo '${file(var.newrelic_ini_path)}' > /home/ubuntu/newrelic-1.ini
export NEW_RELIC_CONFIG_FILE=/home/ubuntu/newrelic-1.ini
nohup newrelic-admin run-program python3 /home/ubuntu/app.py &
EOF
# Copy app.py to the EC2 instance
provisioner "file" {
source = var.app_file
destination = "/home/ubuntu/app.py"
connection {
type = "ssh"
user = "ubuntu"
private_key = file(var.private_key_path)
host = aws_instance.flask_app.public_ip
}
}
# Copy newrelic-1.ini to the EC2 instance
provisioner "file" {
source = var.newrelic_ini_path # Absolute path to newrelic-1.ini
destination = "/home/ubuntu/newrelic-1.ini"
connection {
type = "ssh"
user = "ubuntu" # Default Ubuntu user
private_key = file(var.private_key_path)
host = aws_instance.flask_app.public_ip
}
}
}
# Output the EC2 instance's public IP and DNS
output "instance_public_ip" {
description = "Public IP address of the EC2 instance"
value = aws_instance.flask_app.public_ip
}
output "instance_public_dns" {
description = "Public DNS of the EC2 instance"
value = aws_instance.flask_app.public_dns
}
output "flask_app_new_relic_setup" {
description = "New Relic monitoring confirmation"
value = "New Relic monitoring enabled. Check your New Relic APM dashboard."
}
