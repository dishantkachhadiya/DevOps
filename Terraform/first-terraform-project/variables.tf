variable "instance_type" {
   description = "The EC2 instance size"
   type = string
   default = "t3.micro" 
}

variable "ami_id" {
   description = "AMI to use for the instance"
   type = string
   default = "ami-0c02fb55956c7d316"
}
