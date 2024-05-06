output "glue_role" {
  description = "ARN of the Glue Role"
  value       = aws_iam_role.glue_role.arn
}