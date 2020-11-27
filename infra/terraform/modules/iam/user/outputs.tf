output arn {
  value = aws_iam_user.this.arn
}

output name {
  value = aws_iam_user.this.name
}

output secret_key_pgp {
  value = aws_iam_access_key.this.encrypted_secret
}

output access_secret {
  value = concat (
    aws_iam_access_key.this.*.id,
    aws_iam_access_key.this.*.secret,
  )
}