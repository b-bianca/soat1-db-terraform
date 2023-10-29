#defining the provider as aws
provider "aws" {
    region     = "${var.AWS_REGION}"
    access_key = "${var.AWS_ACCESS_KEY}"
    secret_key = "${var.AWS_SECRET_KEY}"
}

#create a security group for RDS Database Instance
resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#create a RDS Database Instance
resource "aws_db_instance" "db-instance" {
  engine               = "mysql"
  identifier           = var.DB_NAME
  allocated_storage    =  20
  engine_version       = "8.0.33"
  instance_class       = "db.t2.micro"
  username             = var.DB_USER
  password             = var.DB_PASSWORD
  parameter_group_name = "default.mysql8.0.33"
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  skip_final_snapshot  = true
  publicly_accessible =  true
}