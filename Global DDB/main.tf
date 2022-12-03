provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
}

provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
  shared_credentials_file = "~/.aws/credentials"
}

resource "aws_dynamodb_table" "DemoTable" {
  provider = "aws.us-east-1"

  hash_key         = "TestAttribute"
  name             = "TestTable"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  read_capacity    = 1
  write_capacity   = 1

  attribute {
    name = "TestAttribute"
    type = "S"
  }
}

resource "aws_dynamodb_table" "DemoTable2" {
  provider = "aws.us-west-2"

  hash_key         = "TestAttribute"
  name             = "TestTable"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  read_capacity    = 1
  write_capacity   = 1

  attribute {
    name = "TestAttribute"
    type = "S"
  }
}

resource "aws_dynamodb_global_table" "TestTable" {
  depends_on = ["aws_dynamodb_table.DemoTable", "aws_dynamodb_table.DemoTable2"]
  provider   = "aws.us-east-1"

  name = "TestTable"

  replica {
    region_name = "us-east-1"
  }

  replica {
    region_name = "us-west-2"
  }
}