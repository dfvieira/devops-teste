output id {
  value = module.sqs_queue.id
}

output sender_user {
  value = module.sqs_user_sender.access_secret
}

output receiver_user {
  value = module.sqs_user_receiver.access_secret
}