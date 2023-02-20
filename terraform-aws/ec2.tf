resource "aws_instance" "master" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key_pair
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name        = var.name
    Environment = var.env
    Provisioner = "Terraform"
  }

  connection {
    type     	= "ssh"
    user     	= "admin"
#    private_key	= file("/home/igor/Downloads/aws-k8s.pem")
    private_key	= file("${var.private_key}")
    host     	= self.public_ip
  }

  provisioner "remote-exec" {
    inline = ["echo 'Cloud Server ready!'"]
  }

  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u admin --private-key ${var.private_key} -i '${self.public_ip},' /home/igor/vms/ansible/master-containerd-aws.yml"
  }

}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
#     cidr_blocks      = [ "0.0.0.0/0", ]
#     cidr_blocks      = [ "190.15.118.34/32", ]
     cidr_blocks      = [ "23.175.192.147/32", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}
