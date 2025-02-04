resource "aws_route53_record" "expense" {
  count           = length(var.instances)
  zone_id         = var.zone_id
  ttl             = 1
  records         = [var.instances[count.index]=="frontend" && var.environment =="prod" ? aws_instance.this[count.index].public_ip : aws_instance.this[count.index].private_ip]
  name            = var.instances[count.index]=="frontend" && var.environment =="prod"? var.domain_name : "${var.instances[count.index]}-${var.environment}.${var.domain_name}"
  type            = "A"
  allow_overwrite = true
}