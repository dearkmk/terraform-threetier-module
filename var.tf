variable "privatekeypath" {
    default = ".//Keys/terraform.pem"
}
# Variables to be taken as parameters
variable "aws_accesskey" {}

variable "aws_secretkey" {}
variable "aws_region" {}