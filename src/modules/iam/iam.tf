resource "aws_iam_role" "glue_role" {
  name = "glue_role"
  assume_role_policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

variable "policy_arns" {
  type = list(string)
  default = ["arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole","arn:aws:iam::aws:policy/AmazonS3FullAccess"]
}

resource "aws_iam_role_policy_attachment" "glue-role-policy-attachment" {
  # for_each = toset(["arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole","arn:aws:iam::aws:policy/AmazonS3FullAccess"])
  count = length(var.policy_arns)
  role       = aws_iam_role.glue_role.name
  policy_arn = var.policy_arns[count.index]
}


# resource "aws_iam_policy" "AmazonS3ReadOnlyAccess" {
#   name = "AmazonS3ReadOnlyAccess"
#   policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "s3:Get*",
#                 "s3:List*",
#                 "s3:Describe*",
#                 "s3-object-lambda:Get*",
#                 "s3-object-lambda:List*"
#             ],
#             "Resource": "*"
#         }
#     ]
# })
# }

# resource "aws_iam_policy" "AWSGlueConsoleFullAccess" {
#   name = "AWSGlueConsoleFullAccess"
#   policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "BaseAppPermissions",
#             "Effect": "Allow",
#             "Action": [
#                 "glue:*",
#                 "redshift:DescribeClusters",
#                 "redshift:DescribeClusterSubnetGroups",
#                 "iam:ListRoles",
#                 "iam:ListUsers",
#                 "iam:ListGroups",
#                 "iam:ListRolePolicies",
#                 "iam:GetRole",
#                 "iam:GetRolePolicy",
#                 "iam:ListAttachedRolePolicies",
#                 "ec2:DescribeSecurityGroups",
#                 "ec2:DescribeSubnets",
#                 "ec2:DescribeVpcs",
#                 "ec2:DescribeVpcEndpoints",
#                 "ec2:DescribeRouteTables",
#                 "ec2:DescribeVpcAttribute",
#                 "ec2:DescribeKeyPairs",
#                 "ec2:DescribeInstances",
#                 "ec2:DescribeImages",
#                 "rds:DescribeDBInstances",
#                 "rds:DescribeDBClusters",
#                 "rds:DescribeDBSubnetGroups",
#                 "s3:ListAllMyBuckets",
#                 "s3:ListBucket",
#                 "s3:GetBucketAcl",
#                 "s3:GetBucketLocation",
#                 "cloudformation:ListStacks",
#                 "cloudformation:DescribeStacks",
#                 "cloudformation:GetTemplateSummary",
#                 "dynamodb:ListTables",
#                 "kms:ListAliases",
#                 "kms:DescribeKey",
#                 "cloudwatch:GetMetricData",
#                 "cloudwatch:ListDashboards",
#                 "databrew:ListRecipes",
#                 "databrew:ListRecipeVersions",
#                 "databrew:DescribeRecipe"
#             ],
#             "Resource": [
#                 "*"
#             ]
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "s3:GetObject",
#                 "s3:PutObject"
#             ],
#             "Resource": [
#                 "arn:aws:s3:::aws-glue-*/*",
#                 "arn:aws:s3:::*/*aws-glue-*/*",
#                 "arn:aws:s3:::aws-glue-*"
#             ]
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "tag:GetResources"
#             ],
#             "Resource": [
#                 "*"
#             ]
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "s3:CreateBucket"
#             ],
#             "Resource": [
#                 "arn:aws:s3:::aws-glue-*"
#             ]
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "logs:GetLogEvents"
#             ],
#             "Resource": [
#                 "arn:aws:logs:*:*:/aws-glue/*"
#             ]
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "cloudformation:CreateStack",
#                 "cloudformation:DeleteStack"
#             ],
#             "Resource": "arn:aws:cloudformation:*:*:stack/aws-glue*/*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ec2:RunInstances"
#             ],
#             "Resource": [
#                 "arn:aws:ec2:*:*:instance/*",
#                 "arn:aws:ec2:*:*:key-pair/*",
#                 "arn:aws:ec2:*:*:image/*",
#                 "arn:aws:ec2:*:*:security-group/*",
#                 "arn:aws:ec2:*:*:network-interface/*",
#                 "arn:aws:ec2:*:*:subnet/*",
#                 "arn:aws:ec2:*:*:volume/*"
#             ]
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ec2:TerminateInstances",
#                 "ec2:CreateTags",
#                 "ec2:DeleteTags"
#             ],
#             "Resource": [
#                 "arn:aws:ec2:*:*:instance/*"
#             ],
#             "Condition": {
#                 "StringLike": {
#                     "ec2:ResourceTag/aws:cloudformation:stack-id": "arn:aws:cloudformation:*:*:stack/aws-glue-*/*"
#                 },
#                 "StringEquals": {
#                     "ec2:ResourceTag/aws:cloudformation:logical-id": "ZeppelinInstance"
#                 }
#             }
#         },
#         {
#             "Action": [
#                 "iam:PassRole"
#             ],
#             "Effect": "Allow",
#             "Resource": "arn:aws:iam::*:role/AWSGlueServiceRole*",
#             "Condition": {
#                 "StringLike": {
#                     "iam:PassedToService": [
#                         "glue.amazonaws.com"
#                     ]
#                 }
#             }
#         },
#         {
#             "Action": [
#                 "iam:PassRole"
#             ],
#             "Effect": "Allow",
#             "Resource": "arn:aws:iam::*:role/AWSGlueServiceNotebookRole*",
#             "Condition": {
#                 "StringLike": {
#                     "iam:PassedToService": [
#                         "ec2.amazonaws.com"
#                     ]
#                 }
#             }
#         },
#         {
#             "Action": [
#                 "iam:PassRole"
#             ],
#             "Effect": "Allow",
#             "Resource": [
#                 "arn:aws:iam::*:role/service-role/AWSGlueServiceRole*"
#             ],
#             "Condition": {
#                 "StringLike": {
#                     "iam:PassedToService": [
#                         "glue.amazonaws.com"
#                     ]
#                 }
#             }
#         }
#     ]
# })

# #   tags = {
# #     tag-key = "tag-value"
# #   }
# }