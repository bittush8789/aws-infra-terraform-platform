resource "aws_kms_key" "this" {
  description             = "KMS key for ${var.project_name}-${var.environment}"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-kms-key"
  })
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.project_name}-${var.environment}-key"
  target_key_id = aws_kms_key.this.key_id
}

variable "project_name" {}
variable "environment" {}
variable "tags" { default = {} }

output "key_id" {
  value = aws_kms_key.this.key_id
}

output "key_arn" {
  value = aws_kms_key.this.arn
}
