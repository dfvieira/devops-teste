variable visibility_timeout_seconds {
    default = "30"
}

variable delay_seconds {
    default = "0"
}

variable max_message_size {
    default = "262144"
}

variable message_retention_seconds {
    default = "345600"
}

variable receive_wait_time_seconds {
    default = "0"
}

variable sqs_queue_name {

}

variable tags {
    default = {}
}

variable fifo_queue {
    default = false
}

variable content_based_deduplication {
    default = false
}

variable policy {
}