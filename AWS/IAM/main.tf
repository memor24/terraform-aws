##### account ####
module "iam_iam-account" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-account"
  version = "5.52.2"

  iam_account_alias = var.iam_account_alias
  # account password palicy
  max_password_age             = 180
  min_password_length          = 10
  require_uppercase_characters = true
  require_lowercase_characters = true
  require_symbols              = true
  require_numbers              = true
}



### user ###
module "iam_iam-user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.52.2"

  # iam user with iam policy attached
  name                         = var.user_name
  creat_iam_user_login_profile = false
  creat_iam_access_key         = true
  policy_arns                  = [data.aws_iam_policy.choose.arn]
  tags = {
    Environment = "dev"
  }
}
data "aws_iam_policy" "choose" {
  name = var.aws_iam_policy_name
}

### group ###

### role ###

### policy binding ### 