resource "random_string" "bucket" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_s3_bucket" "website" {
  bucket = "rose-devops-portfolio-${random_string.bucket.result}"
}

resource "aws_s3_object" "website_files" {
  for_each = fileset("../website_code", "**")

  bucket = aws_s3_bucket.website.id

  key    = each.value
  source = "../website_code/${each.value}"

  etag = filemd5("../website_code/${each.value}")

  content_type = lookup(
    {
      html = "text/html"
      css  = "text/css"
      js   = "application/javascript"
      jpg  = "image/jpeg"
      jpeg = "image/jpeg"
      png  = "image/png"
      svg  = "image/svg+xml"
      pdf  = "application/pdf"
    },
    split(".", each.value)[length(split(".", each.value)) - 1],
    "application/octet-stream"
  )
}

resource "aws_s3_bucket_policy" "allow_cloudfront" {

  bucket = aws_s3_bucket.website.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AllowCloudFront"
        Effect = "Allow"

        Principal = {
          Service = "cloudfront.amazonaws.com"
        }

        Action = [
          "s3:GetObject"
        ]

        Resource = [
          "${aws_s3_bucket.website.arn}/*"
        ]

        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.website.arn
          }
        }
      }
    ]
  })
}