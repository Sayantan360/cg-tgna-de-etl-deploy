output "glue_role_arn" {
  description = "ARN of Glue Role"
  value       = module.iam.glue_role_arn
}

output "glue_role_name" {
  description = "ARN of Glue Role"
  value       = module.iam.glue_role_name
}

output "mybucket" {
  description = "Name of the S3 Bucket"
  value       = module.s3.mybucket
}

output "mybucket2" {
  description = "Name of the S3 Bucket"
  value       = module.s3.mybucket2
}