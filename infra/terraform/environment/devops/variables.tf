variable region {
    default = "us-east-1"
}

variable sqs_policy {
    default = <<POLICY
{
   "Version": "2012-10-17",
   "Id": "Queue_Policy_UUID",
   "Statement": [{
      "Sid":"Queue1_AllActions",
      "Effect": "Allow",
      "Principal": {
         "AWS": "arn:aws:iam::721411679615:user/sqs-sender"
      },
      "Action": [
      "sqs:SendMessage",
      "sqs:ListQueues"
      ],
      "Resource": "arn:aws:sqs:us-east-1:721411679615:sqs-sugestao"
   },
   {
      "Sid":"Queue2_AllActions",
      "Effect": "Allow",
      "Principal": {
         "AWS": "arn:aws:iam::721411679615:user/sqs-receiver"
      },
      "Action": [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:ListQueues"
      ],
      "Resource": "arn:aws:sqs:us-east-1:721411679615:sqs-sugestao"
   }]
}
POLICY
}

variable policy_user_sender {
    default = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": [
      "sqs:SendMessage",
      "sqs:ListQueues"
      ],
    "Resource": "*"
  }
}
POLICY
}

variable policy_user_receiver {
    default = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:ListQueues"
      ],
    "Resource": "*"
  }
}
POLICY
}