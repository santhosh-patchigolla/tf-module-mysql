# Whenever you have some common fields or anything which is highly used, you can consider that in locals and can call it on your need

locals {
    MYSQL_USER  = jsondecode(data.aws_secretsmanager_secret_version.secret_version.secret_string)["MYSQL_USERNAME"]
    MYSQL_PASS  = jsondecode(data.aws_secretsmanager_secret_version.secret_version.secret_string)["MYSQL_PASSWORD"]
}


