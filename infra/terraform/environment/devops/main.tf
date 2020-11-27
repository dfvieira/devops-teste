module sqs_queue {
  source = "../../modules/sqs-queue"
  sqs_queue_name = "sqs-sugestao"
  policy = var.sqs_policy

  tags = merge(
    local.common_tags)
}

module sqs_user_sender {
  source = "../../modules/iam/user"
  iam_name = "sqs-sender"
  policy_name = "policy-sqs-create-queue"
  policy = var.policy_user_sender

  tags = merge(
    local.common_tags)
}

module sqs_user_receiver {
  source = "../../modules/iam/user"
  iam_name = "sqs-receiver"
  policy_name = "policy-sqs-create-queue"
  policy = var.policy_user_receiver

  tags = merge(
    local.common_tags)
}