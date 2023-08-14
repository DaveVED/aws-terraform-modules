resource "aws_kms_key" "key" {
  description             = "${var.project} ${var.environment} ${var.ecs_cluster_name} kms key"
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 7
  is_enabled              = true
  enable_key_rotation     = false
  multi_region            = false

  policy = <<EOF
{
   "Version":"2012-10-17",
   "Id":"key-default-1",
   "Statement":[
      {
         "Sid":"IAMUserPermissions",
         "Effect":"Allow",
         "Principal":{
            "AWS":"arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
         },
         "Action":"kms:*",
         "Resource":"*"
      },
      {
         "Sid":"ECSAllow",
         "Effect":"Allow",
         "Principal":{
            "Service":"ecs-tasks.amazonaws.com"
         },
         "Action":[
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:DescribeKey"
         ],
         "Resource":"*"
      }
   ]
}
EOF

  tags = var.default_tags
}

resource "aws_kms_alias" "alias" {
  name          = "alias/ecs"
  target_key_id = aws_kms_key.key.arn
}