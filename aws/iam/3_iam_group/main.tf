
### group ###

# define devops users
module "iam_devops_users" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.52.2"

  foreach= list_to_set(var.devops_users)

  name=each.value
  creat_iam_user_login_profile = false
  creat_iam_access_key         = false
}

# superadmin group access for devops
module "iam_group_devops_access" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "5.52.2"

  name                     = "devops_access"
  group_users              = [module.iam_user1.name]
  custom_group_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  tags = {
    group = "devops"
  }
}


# dev user; foreach can be used to define a list of dev users too
module "iam_dev_users" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.52.2"
 
  name                         = "dev1"
  creat_iam_user_login_profile = false
  creat_iam_access_key         = false
}

# custom access for developers
module "iam_group_dev_accesss" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "5.52.2"

  name                     = "developers_access"
  group_users              = [module.iam_user2.name]
  custom_group_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
  custom_group_policies = [
    {
      name        = "AllowS3Listing"
      description = "more granular s3 access"
      policy      = aws_iam_policy_document.samples.json
    }
  ]
  tags = {
    group = "developers"
  }
}

# sample policy document for the group
data "aws_iam_policy_document" "samples" {
  version = "2012-10-17"
  statement = [
    {
      effect   = "Allow"
      action   = ["s3:ListBucket"]
      resource = ["*"]
    },
    {
      effect   = "Allow"
      action   = ["s3:GetObject"]
      resource = ["arn:aws:s3:::dev_bucket/*"]
    }
  ]
}
