provider "aws" {
 region = "us-east-1"

}



resource "aws_s3_bucket" "b" {
  bucket = "abhi134-bucket"


  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
