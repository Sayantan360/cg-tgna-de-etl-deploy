resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_object" "file" {
  bucket = "aws_s3_bucket.mybucket.id"
  key    = "glue_script.py"
  source = "./glue_script.py"

}