output "glue_role_arn" {
  description = "ARN of the Glue Role"
  value       = aws_iam_role.glue_role.arn
}