output "glue_role" {
  description = "ARN of Glue Role"
  value       = module.glue.glue_role
}

output "mybucket" {
  description = "Name of the S3 Bucket"
  value       = module.s3.mybucket
}

output "mybucket2" {
  description = "Name of the S3 Bucket"
  value       = module.s3.mybucket2
}