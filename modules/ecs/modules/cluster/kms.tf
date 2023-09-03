resource "aws_kms_key" "key" {
  description             = "${var.project} ${var.environment} ${var.ecs_cluster_name} kms key"
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 7
  is_enabled              = true
  enable_key_rotation     = false
  multi_region            = false
  policy                  = data.aws_iam_policy_document.kms_policy.json

  tags = var.default_tags
}

data "aws_iam_policy_document" "kms_policy" {
  statement {
    sid    = "IAMUserPermissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid    = "ECSAllow"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]
  }
}

resource "aws_kms_alias" "alias" {
  name          = "alias/${var.project}/ecs-cluster"
  target_key_id = aws_kms_key.key.arn
}
