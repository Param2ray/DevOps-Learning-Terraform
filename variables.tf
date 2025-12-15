variable "instance_type" {
    type = string
    default = "t2.micro"
}

locals {
    instance_ami = "ami-0abac8735a38475db"  
}


