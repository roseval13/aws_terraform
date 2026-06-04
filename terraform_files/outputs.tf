output "cloudfront_url" {
  value = aws_cloudfront_distribution.website.domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront Distribution ID"
  value       = aws_cloudfront_distribution.website.id
}

output "cloudfront_distribution_domain_name" {
  description = "CloudFront Domain Name"
  value       = aws_cloudfront_distribution.website.domain_name
}

output "bucket_name" {
  description = "Website bucket"
  value       = aws_s3_bucket.website.bucket
}