module "aws_web_vpc" {
  source            = "./modules/aws-web-vpc"
  vpc_cidr_block    = var.vpc_cidr
  subnet_cidr_block = var.subnet_cidr
}

module "web1" {
  source            = "./modules/aws-web-server-instance"
  ec2_instance_type = var.ec2_instance_type
  ec2_instance_name = "web-num1"

  vpc_id        = module.aws_web_vpc.vpc_id
  subnet_id     = module.aws_web_vpc.subnet_id
  web_server_sc = module.aws_web_vpc.web_sec_group
}

module "web2" {
  source            = "./modules/aws-web-server-instance"
  ec2_instance_name = "web-num2"
  ec2_instance_type = var.ec2_instance_type
  vpc_id            = module.aws_web_vpc.vpc_id
  subnet_id         = module.aws_web_vpc.subnet_id
  web_server_sc     = module.aws_web_vpc.web_sec_group

}

module "bucket1" {
  source = "./modules/my_s3"

  bucket_name       = "bucket-1"
  bucket_versioning = true
  profile           = var.profile
}

module "bucket2" {
  source = "./modules/my_s3"

  bucket_name       = "bucket-2"
  bucket_versioning = false
  profile           = var.profile
}

module "bucketx" {
  source = "./modules/my_s3"

  count             = 3
  bucket_name       = "bucket-x-${count.index}"
  bucket_versioning = true
  profile           = var.profile
}
