resource "aws_db_subnet_group" "db_subnet_group" {
  name = "db-subnet"
  subnet_ids = [aws_subnet.priv-sub-1.id,aws_subnet.priv-sub-2.id]
}



resource "aws_db_instance" "project-db" {
  identifier = "project-db"
  allocated_storage    = 5
  db_name              = "mydb"
  engine               = "postgres"
  engine_version       = "14.5"
  instance_class       = "db.t3.micro"
  username             = "Nanayaw"
  password             = "Ug10204438"
  vpc_security_group_ids = [aws_security_group.db-sec-grp.id]
  /* parameter_group_name = "default.mysql5.7" */
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
}
