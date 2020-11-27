resource aws_iam_user this {
  name = var.iam_name
  force_destroy = var.force_destroy
  tags = var.tags
}

resource aws_iam_access_key this {
  user    = aws_iam_user.this.name
}

resource aws_iam_user_policy this {
  name = var.policy_name
  user = aws_iam_user.this.name
  policy = var.policy
}
