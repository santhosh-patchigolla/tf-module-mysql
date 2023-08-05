# Creating RDS : MySQL

resource "aws_db_instance" "mysql" {
  allocated_storage    = var.MYSQL_STORAGE
  engine               = "mysql"
  engine_version       = var.MYSQL_ENGINE_VERSION
  instance_class       = var.MYSQL_INSTANCE_TYPE 
  username             = local.MYSQL_USER   //   got it from the local.tf and from the AWS secret manager
  password             = local.MYSQL_PASS
  parameter_group_name = aws_db_parameter_group.mysql_pg.name
  skip_final_snapshot  = true
  db_subnet_group_name    = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.allows_mysql.id]
}

# creates subnet group 
resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "roboshop-mysql-${var.ENV}-subnetgroup"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "roboshop-mysql-${var.ENV}-subnetgroup"
  }
}

resource "aws_db_parameter_group" "mysql_pg" {
  name   = "roboshop-${var.ENV}-mysql-pg"
  family = "mysql5.7"
}








# Creating Elastic Cache Cluster : Redis
/* resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "roboshop-${var.ENV}-redis"
  engine               = "redis"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.redis_pg.name
  engine_version       = "6.x"
  port                 = 6379 
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids   = [aws_security_group.allows_redis.id]   
}

# Creating Parameter Group needed for Elastic Cache
resource "aws_elasticache_parameter_group" "redis_pg" {
  name   = "roboshop-${var.ENV}-redis-pg"
  family = "redis6.x"
}


# creates subnet group 
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "roboshop-redis-${var.ENV}-subnetgroup"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "roboshop-redis-${var.ENV}-subnetgroup"
  }
} */


