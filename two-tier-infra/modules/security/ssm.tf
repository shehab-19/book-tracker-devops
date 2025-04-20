data "aws_ssm_parameter" "db-password" {
  name = "/bookstore/dbpassword"
}
data "aws_ssm_parameter" "db-username" {
  name = "/bookstore/dbusername"
}
