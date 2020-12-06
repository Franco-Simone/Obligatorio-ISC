resource "aws_instance" "instance-obl" {
  ami           = "ami-0affd4508a5d2481b"
  instance_type = "t2.small"
  key_name      = var.aws_key
  subnet_id     = aws_subnet.private-subnet-obl.id
  vpc_security_group_ids = [
    aws_security_group.sg-ssh-obl.id,
    aws_security_group.sg-efs-obl.id,
    aws_security_group.sg-http-obl.id,
  ]
  tags = {
    Name      = "Instance-bkp-OBL"
    Terraform = "True"
  }
  user_data = <<USER_DATA
#!/bin/bash
sudo su
curl -O https://raw.githubusercontent.com/mauricioamendola/simple-ecomme/master/dump.sql
yum install -y mysql nfs-common
mkdir /mnt/efs
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-7811888d.efs.us-east-1.amazonaws.com:/ /mnt/efs/
echo 'fs-7811888d.efs.us-east-1.amazonaws.com:/ /mnt/efs                nfs4    defaults        0 0' >> /etc/fstab
mysql -h obl-rds.cvvx3frln7hh.us-east-1.rds.amazonaws.com -uadmin -padmin123 idukan < dump.sql
  USER_DATA
  
}


