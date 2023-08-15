# AWS Terraform Modules
Collection of guard railed Terraform modules supporting AWS deployments. 

The purpose of these modules is to not give complete flexiablity, or provison a single resource. Instead the the moudles should serve the purpose of not only provsiong resrouces, but should proivde default configs, to follow aws best pratice, enable guard rails, and provison supporting resrouces to meet these needs. For example the ECS cluster module not only gives you a cluster, but provides cloudwatch logging plus kms encryption.