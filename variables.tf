variable "key_name" {
description = "The name of the SSH key pair"
type = string
}
variable "app_file" {
description = "Path to the Flask app.py file"
type = string
}
variable "private_key_path" {
description = "The path to the SSH private key for connecting to EC2 instances"
type = string
}
variable "new_relic_license_key" {
description = "New Relic License Key for APM monitoring"
type = string
}
variable "new_relic_account_id" {
description = "The New Relic account ID"
type = string
}
variable "newrelic_ini_path" {
description = "Path to the New Relic configuration file"
type = string
}
Summary: The `variables.tf` file defines input variables for reusability and customization,
including credentials and file paths.
File - terraform.tfvars
key_name = "Test"
app_file = "/Users/sathyanarayanan/Desktop/Assignment-web/app.py"
private_key_path = "/Users/sathyanarayanan/Desktop/Test.pem"
new_relic_license_key = "eu01xxbbb98af6d0b9065449b3d3de11XXXXXX"
new_relic_account_id = "10065218XX"
newrelic_ini_path = "/Users/sathyanarayanan/Desktop/newrelic-1.ini"
