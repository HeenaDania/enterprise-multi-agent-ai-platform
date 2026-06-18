terraform {
  backend "s3" {
    # Replace with the exact unique name of your pre-existing S3 Bucket
    bucket         = "heena-dania-tfstate-bucket" 
    
    # The path and filename inside the bucket where your state file will live
    key            = "dev/infrastructure/terraform.tfstate" 
    
    region         = "us-east-1"
    
    # Forces state files to be securely encrypted at rest inside S3
    encrypt        = true 
    
    # Replace with the exact name of your pre-existing DynamoDB Table for lock management
    dynamodb_table = "heena-dania-tfstate-locks" 
  }
}
