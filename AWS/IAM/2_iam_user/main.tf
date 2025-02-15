
### users ###
module "iam_devops_user" {
    source  = "terraform-aws-modules/iam/aws//modules/iam-user"
    version = "5.52.2"

  # an iam user with an iam policy attached
  name                         = "devops3"
  creat_iam_user_login_profile = false
  creat_iam_access_key         = true
  policy_arns                  = [data.aws_iam_policy.choose.arn]
  tags = {
    Environment = "demo"
  }
}
# choose the specific policy for the user
data "aws_iam_policy" "choose" {
  name = var.aws_iam_policy_name
}

