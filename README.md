# AWS Terraform Modules

Collection of reusable terraform modules. The modules are not meant to give you complete flexibility but instead provide you with required resources (and supporting resources) to deploy the module.

Each module can be used in isolation or together with each other. If leveraged together modules from this repository should allow you to create a complete three tier application in AWS with networking, data store, compute, etc...

## Current Support
Right now there is supporting for the following modules. More details on what each one does can be found in that modules respective `README.md`

- [] VPC - Create a stable AWS networking configuration.
- [] DynamoDb - Create a standarized DynamoDb table/configuration.
- [] ECS -
    - [] Cluster
    - [] Task Defintion
    - [] Service
    - [] ALB