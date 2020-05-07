resource "aws_instance" "web-ec2" {
  ami           = "ami-0915e09cc7ceee3ab"
  instance_type = "t2.micro"
  subnet_id= aws_subnet.main.id
  associate_public_ip_address= "true"
  
  tags = {
    Name = "CTF-ANKABABU-WEB-1"
  }
}

resource "aws_elb" "bar" {
  name               = "CTF-terraform-elb"
  availability_zones = ["us-east-1d"]


  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }


  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = ["${aws_instance.web-ec2.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "CTF-terraform-elb"
  }
}


