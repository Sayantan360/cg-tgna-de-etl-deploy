resource "aws_glue_catalog_database" "glue_db" {
  name = "MyCatalogDatabase"
}

resource "aws_glue_crawler" "events_crawler" {
  database_name = aws_glue_catalog_database.glue_db.name
#   schedule      = "cron(0 1 * * ? *)"
  name          = "test_crawler"
  role          = aws_iam_role.glue_role.arn

  s3_target {
    path = "s3://${aws_s3_bucket.mybucket2.bucket}"
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

resource "aws_glue_job" "test_glue_job" {
  name     = "test_glue_job"
  role_arn = aws_iam_role.glue_role.arn

  command {
    script_location = "s3://${aws_s3_bucket.mybucket.bucket}/glue_script.py"
  }
}