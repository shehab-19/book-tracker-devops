resource "aws_iam_policy" "ssm_read_policy" {
  name        = "SSMReadPolicy"
  description = "Allows Terraform to read SSM parameters"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ]
        Resource = "arn:aws:ssm:us-east-1:123456789012:parameter/bookstore/*"
      }
    ]
  })
}
