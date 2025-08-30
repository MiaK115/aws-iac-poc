output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.this.dns_name
}

output "rds_endpoint" {
  description = "RDS endpoint for application/database connections"
  value       = aws_db_instance.this.address
}

output "vpc_id" {
  value = aws_vpc.this.id
}
