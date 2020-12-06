resource "aws_db_instance" "rds-obl" {
  allocated_storage    = 20
  max_allocated_storage = 50
  identifier           = "obl-rds"
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.small"
  name                 = var.initial_db_name
  username             = var.aws_db_usr
  password             = var.aws_db_pass
  port                 = 3306
  backup_retention_period = 30
  copy_tags_to_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.subnet-group-obl.name
  vpc_security_group_ids = [aws_security_group.sg-db-obl.id]
  multi_az             = true
  skip_final_snapshot  = true

  tags = {
    Name = "OBL-rds"
    Terraform = "True"
  }
}

resource "aws_db_subnet_group" "subnet-group-obl" {
  name       = "sn-group-obl"
  subnet_ids = [aws_subnet.private-subnet-obl.id, aws_subnet.private-subnet-obl1.id]

  tags = {
    Name = "OBL-subnet-group"
    Terraform = "True"
  }
}