resource aws_sqs_queue this {
  name                 = var.sqs_queue_name
  fifo_queue                  = var.fifo_queue
  content_based_deduplication = var.content_based_deduplication
  visibility_timeout_seconds = var.visibility_timeout_seconds
  delay_seconds             = var.delay_seconds
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds
  
  tags = var.tags
}

resource time_sleep wait_10_seconds {
  depends_on = [aws_sqs_queue.this]

  create_duration = "10s"
}

resource aws_sqs_queue_policy this {
  queue_url = aws_sqs_queue.this.id
  policy = var.policy
  
  depends_on = [time_sleep.wait_10_seconds]
}
