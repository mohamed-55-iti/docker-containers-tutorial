provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}



  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ../ansible/hosts"
  }
}


resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Example AMI ID
  instance_type = "t2.micro"
}
