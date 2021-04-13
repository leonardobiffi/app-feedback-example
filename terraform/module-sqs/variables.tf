variable "queue_name" {
  description = "Name of Resource SQS Queue"
}

variable "policy" {
  description = "Policy SQS Queue"
}

variable "tags" {
  description = "Resource tags"
  default = {}
}