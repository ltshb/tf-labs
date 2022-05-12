resource "aws_s3_bucket" "this" {
  bucket        = "${var.profile}-${var.bucket_name}"
  force_destroy = true

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_acl" "private" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.bucket_versioning ? "Enabled" : "Disabled"
  }
}


locals {
  readme_file          = "./modules/my_s3/files-to-upload/README.md"
  specific_readme_file = "./modules/my_s3/files-to-upload/README_${var.bucket_name}.md"
  readme_template      = "./modules/my_s3/files-to-upload/README.md.tfpl"
  template_value       = templatefile(local.readme_template, { bucket_arn = var.bucket_name })
}

# resource "local_file" "readme" {
#   content  = templatefile(local.readme_template, { bucket_arn = var.bucket_name })
#   filename = local.specific_readme_file
# }

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.this.id
  key    = "README.md"
  #   source = local.specific_readme_file
  content = local.template_value

  #   depends_on = [
  #     local_file.readme
  #   ]
  #   source = local.readme_file

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = md5(local.template_value)
}
