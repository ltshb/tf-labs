## Environment and Project
variable "environment" {
  type        = string
  description = "e.g. test dev prod"
  default     = "dev"
}

variable "project" {
  type    = string
  default = "acme99"
}

## AWS Specific parameters
variable "region" {
  type = string
  default = "eu-west-1"
}

variable "profile" {
  type = string
  default = "tfadmin1"
}

## EC2 Instance Parameters
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
  default = "tf-course"
}


## Security Groups
variable "sec_allowed_external" {
  description = "CIDRs from which access is allowed"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

## ================== Google Cloud vars ================

variable "gcp_region" {
  description = "GCP Region"
  default = "europe-west1"  # Belgium
}
