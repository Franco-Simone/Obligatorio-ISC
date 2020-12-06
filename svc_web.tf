resource "aws_autoscaling_group" "Obligatorio" {
  launch_configuration = aws_launch_configuration.Obligatorio-lc.name
  vpc_zone_identifier = [aws_subnet.private-subnet-obl1.id, aws_subnet.private-subnet-obl.id]
  load_balancers = [aws_elb.Obligatorio-ELB.name]
  health_check_type = "ELB"

  desired_capacity = 1
  min_size = 1
  max_size = 3
  

  lifecycle {
      create_before_destroy = true
  }

  tag {
    key                 = "Obliga"
    value               = "Terraform-aasg-obliga"
    propagate_at_launch = true
  }
}

resource "aws_elb" "Obligatorio-ELB" {
  name               = "obl-elb"
  subnets = [ aws_subnet.private-subnet-obl.id, aws_subnet.private-subnet-obl1.id ]
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = 80
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:80/healthcheck.html"
    interval            = 30
  } 
}

resource "aws_launch_configuration" "Obligatorio-lc" {
  name_prefix = "Web"
  image_id      = "ami-0affd4508a5d2481b"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.sg-http-obl.id, aws_security_group.sg-ssh-obl.id]
  key_name = var.aws_key
  
  lifecycle {
      create_before_destroy = true
  }

  user_data = <<USER_DATA
#!/bin/bash
sudo su
yum install -y httpd php php-mysql git
git clone https://github.com/mauricioamendola/simple-ecomme.git /var/www/html/
echo "Ok" > /var/www/html/healthcheck.html
setsebool -P httpd_can_network_connect_db=1
sed -i 's/localhost/obl-rds.cvvx3frln7hh.us-east-1.rds.amazonaws.com/g' /var/www/html/config.php
sed -i '5 s/root/admin/g' /var/www/html/config.php
sed -i '6 s/root/admin123/g' /var/www/html/config.php
systemctl enable httpd
systemctl start httpd
  USER_DATA

}
