resource "aws_sqs_queue" "frame_extractor_queue" {
  name                      = "${var.frame_extractor_queue_name}-queue"
  delay_seconds             = 0
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.frame_extractor_delay.arn,
    maxReceiveCount     = 1
  })
}

resource "aws_sqs_queue" "frame_extractor_delay" {
  name          = "${var.frame_extractor_queue_name}-delay"
  delay_seconds = 15

  redrive_policy        = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.frame_extractor_dlq.arn,
    maxReceiveCount     = 5
  })
}

resource "aws_sqs_queue" "frame_extractor_dlq" {
  name = "${var.frame_extractor_queue_name}-dlq"
}

resource "aws_sqs_queue_redrive_allow_policy" "frame_extractor_delay" {
  queue_url             = aws_sqs_queue.frame_extractor_delay.id

  redrive_allow_policy  = jsonencode({
    redrivePermission     = "byQueue",
    sourceQueueArns       = [aws_sqs_queue.frame_extractor_queue.arn]
  })
}

resource "aws_sqs_queue_redrive_allow_policy" "frame_extractor_dlq" {
  queue_url             = aws_sqs_queue.frame_extractor_dlq.id

  redrive_allow_policy  = jsonencode({
    redrivePermission     = "byQueue",
    sourceQueueArns       = [aws_sqs_queue.frame_extractor_delay.arn]
  })
}