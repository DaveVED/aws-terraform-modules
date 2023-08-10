# AWS DynamodDb Terraform module
Terraform module which creates a guardrailed (but configurabole) dynamodb setup on AWS.

## Usage
```hcl
module "internet-vpc" {
  source = "git::https://github.com/fundrick/aws-terraform-modules.git//modules/vpc"

  project                = "projct"
  environment            = "environment"
  vpc_cidr               = "10.0.0.0/16"
  
  supported_internet_azs = ["us-east-1a", "us-east-1b"]
  supported_internal_azs = ["us-east-1c", "us-east-1d"]
  
  default_tags           = {}
}

module "bet_table" {
  source = "git::https://github.com/fundrick/aws-terraform-modules.git//modules/dynamodb"

  table_name = "tableName"

  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5

  hash_key  = "users"
  range_key = "details"

  attributes = [
    {
      name = "users"
      type = "S"
    },
    {
      name = "details"
      type = "S"
    }
  ]

  project      = "proejct"
  environment  = "dev"
  default_tags = {}
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | List of attributes for the DynamoDB table. | <pre>list(object({<br>    name = string<br>    type = string<br>  }))</pre> | `[]` | no |
| <a name="input_billing_mode"></a> [billing\_mode](#input\_billing\_mode) | Controls how you are charged for read and write throughput. | `string` | `"PROVISIONED"` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags you would like mapped to all resources created by this module. | `map(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | AWS environment type to deploy the resources to. | `string` | n/a | yes |
| <a name="input_global_secondary_indexes"></a> [global\_secondary\_indexes](#input\_global\_secondary\_indexes) | List of global secondary indexes for the DynamoDB table. | <pre>list(object({<br>    name               = string<br>    hash_key           = string<br>    projection_type    = string<br>    range_key          = optional(string)<br>    read_capacity      = optional(number)<br>    write_capacity     = optional(number)<br>    non_key_attributes = optional(list(string))<br>  }))</pre> | `[]` | no |
| <a name="input_hash_key"></a> [hash\_key](#input\_hash\_key) | Name of the hash key in the index | `string` | n/a | yes |
| <a name="input_point_in_time_recovery_enabled"></a> [point\_in\_time\_recovery\_enabled](#input\_point\_in\_time\_recovery\_enabled) | To enable dynamodb point in time recovery. | `bool` | `false` | no |
| <a name="input_project"></a> [project](#input\_project) | Project name, for which resources are being provisonied. | `string` | n/a | yes |
| <a name="input_range_key"></a> [range\_key](#input\_range\_key) | Attribute to use as the range (sort) key. | `string` | `null` | no |
| <a name="input_read_capacity"></a> [read\_capacity](#input\_read\_capacity) | Number of read units for DynamoDb table. | `number` | `null` | no |
| <a name="input_table_name"></a> [table\_name](#input\_table\_name) | Dynamodb Table Name. | `string` | n/a | yes |
| <a name="input_write_capacity"></a> [write\_capacity](#input\_write\_capacity) | Number of write units for this table.. | `number` | `null` | no |

## Outputs

No outputs.