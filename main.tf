terraform {
  required_providers {
    snowflake = {
      source = "Snowflake-Labs/snowflake"
    }
  }
}

locals {
  organization_name = "chura"
  account_name      = "churad_data"
  private_key_path  = "~/.ssh/tobi_training_service.p8"
}


provider "snowflake" {
    organization_name = local.organization_name
    account_name      = local.account_name
    user              = "tobi_training_service"
    role              = "tobi_training_role"
    authenticator     = "SNOWFLAKE_JWT"
    private_key       = file(local.private_key_path)
}



resource "snowflake_database" "tf_db" {
  name         = "tobi_tfdemo_db"
  is_transient = false
}

resource "snowflake_warehouse" "tf_warehouse" {
  name                      = "tobi_tfdemo_wh"
  warehouse_type            = "STANDARD"
  warehouse_size            = "XSMALL"
  max_cluster_count         = 1
  min_cluster_count         = 1
  auto_suspend              = 60
  auto_resume               = true
  enable_query_acceleration = false
  initially_suspended       = true
}