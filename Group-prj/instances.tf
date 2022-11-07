# 1st ec2 instance on public subnet 1
resource "aws_instance" "ec2_1" {
  ami                    = var.ec2_instance_ami
  instance_type          = var.ec2_instance_type
  availability_zone      = var.az1
  subnet_id              = aws_subnet.public_subnet1.id
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  tags = {
    name = "ec2_1"
  }
}

# 2nd ec2 instance on public subnet 2
resource "aws_instance" "ec2_2" {
  ami                    = var.ec2_instance_ami
  instance_type          = var.ec2_instance_type
  availability_zone      = var.az2
  subnet_id              = aws_subnet.public_subnet2.id
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  tags = {
    name = "ec2_2"
  }
}



# RDS subnet group
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
  tags = {
    name = "rds_subnet_g"
  }
}


# RDS database on mysql engine
resource "aws_db_instance" "my_db" {
  identifier = "wordpress-db"
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.default.id
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  multi_az               = false
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.database_sg.id]
}

