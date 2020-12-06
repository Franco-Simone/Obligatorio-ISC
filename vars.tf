variable "aws_perfil" {
  default = "franco"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "aws_db_usr" {
  default = "admin"
}

variable "aws_db_pass" {
  default = "admin123"
}

variable "aws_key" {
  default = "fsimone"
}

variable "aws_key_path" {
  default = "F:\\fsimone.pem"
}

variable "initial_db_name" {
  default = "idukan"
}

output "public_hostname" {
  value = aws_instance.instance-obl.public_dns
}

output "db_connection" {
  value = aws_db_instance.rds-obl.endpoint
}

output "elb_dns" {
  value = aws_elb.Obligatorio-ELB.dns_name
}

output "dns_name_efs_mnt"{
  value = aws_efs_mount_target.obl-efs-mt.dns_name
}
