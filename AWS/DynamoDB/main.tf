module "dynamodb-table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "4.2.0"

  name                = "new_book_store"
  hash_key            = "id"    # key
  range_key           = "title" # value
  table_class         = "STANDARD"

  attributes = [ # attributes (are key-value pairs)
    {
      name = "id" # primary key
      type = "S"
    },
    {
      name = "title"
      type = "S"
    },
    {
      name = "year" # another value
      type = "N"
    }
  ]

  # indexing
  global_secondary_indexes = [
    {
      name               = "index"
      hash_key           = "title"
      range_key          = "year"
      write_capacity     = 1
      read_capacity      = 1
      projection_type    = "INCLUDE"
      non_key_attributes = ["id"]
    }
  ]

  tags = {
    Environment = "demo"
  }


}
