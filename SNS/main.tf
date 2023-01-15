resource "aws_sns_topic" "user_updates" {
  name = "PubSub.fifo"
  fifo_topic                  = true
  
  #delivery_policy = #To Be Added When deciding format

}
output "ARN" {
    value       = aws_sns_topic.user_updates.arn
  description = "ARN of the sns queue"

  
}