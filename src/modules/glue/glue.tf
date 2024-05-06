resource "aws_glue_catalog_database" "glue_db" {
  name = "catalogdatabase"
}

resource "aws_glue_crawler" "events_crawler" {
  database_name = aws_glue_catalog_database.glue_db.name
#   schedule      = "cron(0 1 * * ? *)"
  name          = "test_crawler"
  role          = module.glue.glue_role_arn

  s3_target {
    path = "s3://${module.s3.mybucket2}"
  }
  
  configuration = jsonencode(
    {
      Grouping = {
        TableGroupingPolicy = "CombineCompatibleSchemas"
      }
      CrawlerOutput = {
        Partitions = { AddOrUpdateBehavior = "InheritFromTable" }
      }
      Version = 1
    }
  )
}

# resource "aws_glue_job" "test_glue_job" {
#   name     = "test_glue_job"
#   role_arn = aws_iam_role.glue_role.arn

#   command {
#     script_location = "s3://${aws_s3_bucket.mybucket.bucket}/glue_script.py"
#   }
# }