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
