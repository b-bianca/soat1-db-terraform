terraform {
  cloud {
    organization = "fiap-postech-soat1-group21"
    workspaces {
      name = "restaurant-database"
    }
  }
}


#defining the provider as aws
provider "aws" {
  region     = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

#create a security group for RDS Database Instance
resource "aws_security_group" "rds_sg" {
  name = "restaurant-database-sg"
  ingress {
    from_port   = var.DB_PORT
    to_port     = var.DB_PORT
    protocol    = "tcp"
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
resource "aws_db_instance" "db_instance" {
  engine                 = "mysql"
  identifier             = var.DB_NAME
  allocated_storage      = 20
  engine_version         = "8.0.33"
  instance_class         = "db.t2.micro"
  username               = var.DB_USER
  password               = var.DB_PASSWORD
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  skip_final_snapshot    = true
  publicly_accessible    = true
}

output "restaurant_database_address" {
  description = "Restaurant database address"
  value = aws_db_instance.db_instance.address
}

data "local_file" "sql_script" {
  filename = "${path.module}/migrations/sql/01_create_database.up.sql"
}

resource "null_resource" "db_setup" {
  depends_on = [aws_db_instance.db_instance, aws_security_group.rds_sg]
  provisioner "local-exec" {
    command = "mysql --host=${aws_db_instance.db_instance.address} --user=${var.DB_PORT} --password=${var.DB_PASSWORD} < ${data.local_file.sql_script.content}"
  }
}
