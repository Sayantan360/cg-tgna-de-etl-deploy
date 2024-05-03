resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  force_destroy = true
}

resource "aws_s3_object" "file" {
  bucket = "aws_s3_bucket.bucket.id"
  key    = "glue_script.py"
  source = "./glue_script.py"

}