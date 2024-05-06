resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket" "mybucket2" {
  bucket = "tgnas3crawlbucket1"
  force_destroy = true
}

resource "aws_s3_object" "file" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "glue_script.py"
  source = "./glue_script.py"

}

resource "aws_s3_object" "file2" {
  bucket = aws_s3_bucket.mybucket2.id
  key    = "areas.json"
  source = "./areas.json"

}