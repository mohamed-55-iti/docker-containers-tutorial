variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "ami_id" {
  default = "ami-0c02fb55956c7d316" # Amazon Linux 2
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "ASIA47CRWR3YBZN6HEEZ"
}
