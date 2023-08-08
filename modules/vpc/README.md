# AWS VPC Terraform module
Terraform module which creates a guardrailed (but configurabole) VPC setup on AWS.

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
| [aws_default_network_acl.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_network_acl) | resource |
| [aws_default_security_group.ingress_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.internal_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.internal_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.internet_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.internal_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.internal_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.internet_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_sg_egress"></a> [default\_sg\_egress](#input\_default\_sg\_egress) | List of egress rules for the deafult Security Group. | <pre>list(object({<br>    from_port = number<br>    to_port   = number<br>    protocol  = string<br>  }))</pre> | <pre>[<br>  {<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_default_sg_ingress"></a> [default\_sg\_ingress](#input\_default\_sg\_ingress) | List of ingress rules for the default Securty Group. | <pre>list(object({<br>    from_port = number<br>    to_port   = number<br>    protocol  = string<br>  }))</pre> | <pre>[<br>  {<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags you would like mapped to all resources created by this module. | `map(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | AWS environment type to deploy the resources to. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project name, for which resources are being provisonied. | `string` | n/a | yes |
| <a name="input_supported_internal_azs"></a> [supported\_internal\_azs](#input\_supported\_internal\_azs) | List of supported AZs for the VPC. | `list(string)` | `[]` | no |
| <a name="input_supported_internet_azs"></a> [supported\_internet\_azs](#input\_supported\_internet\_azs) | List of supported AZs for the VPC. | `list(string)` | `[]` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR block. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID. |