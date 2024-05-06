output "mybucket" {
  description = "Name of the S3 Bucket"
  value       = aws_s3_bucket.mybucket.id
}

output "mybucket2" {
  description = "Name of the S3 Bucket"
  value       = aws_s3_bucket.mybucket2.id
}