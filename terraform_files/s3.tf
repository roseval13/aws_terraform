resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.website.id
  key          = "index.html"
  source       = "../website_code/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "css" {
  bucket       = aws_s3_bucket.website.id
  key          = "styles.css"
  source       = "../website_code/styles.css"
  content_type = "text/css"
}