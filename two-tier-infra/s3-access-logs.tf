# resource "aws_s3_bucket" "access_logs" {
#   bucket = "shehab-ahmed-access-logs-for-alb-bucket"
#   tags = {
#     Name = "access-logs-bucket"
#   }
  
# }

# resource "aws_s3_bucket_public_access_block" "access_logs" {
#   bucket = aws_s3_bucket.access_logs.bucket

#   block_public_acls       = false
#   block_public_policy     = false
#   ignore_public_acls      = false
#   restrict_public_buckets = false
# }

# resource "aws_s3_bucket_policy" "alb_access_logs_policy" {
#   bucket = aws_s3_bucket.access_logs.bucket

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "logdelivery.elb.amazonaws.com"
#         }
#         Action = "s3:PutObject"
#         Resource = "${aws_s3_bucket.access_logs.arn}/*"
#       }
#     ]
#   })
# }
