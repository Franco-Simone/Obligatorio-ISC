

resource "aws_efs_file_system" "obl-efs" {
  creation_token = "obl-efs"

  tags = {
    Name = "OBL-efs"
  
  }

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
}

resource "aws_efs_mount_target" "obl-efs-mt" {
  file_system_id = aws_efs_file_system.obl-efs.id
  subnet_id      = aws_subnet.private-subnet-obl.id
  security_groups = [aws_security_group.sg-efs-obl.id]
}





