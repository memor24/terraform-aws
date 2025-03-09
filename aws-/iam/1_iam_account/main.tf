
##### account ####
module "iam_iam-account" {
    source  = "terraform-aws-modules/iam/aws//modules/iam-account"
    version = "5.52.2"

  # account alias; has to be unique accross all organization accounts
  iam_account_alias = var.iam_account_alias

  # account password policy
  max_password_age             = 180
  min_password_length          = 10
  require_uppercase_characters = true
  require_lowercase_characters = true
  require_symbols              = true
  require_numbers              = true
}
