terraform {
  backend "s3" {
    bucket         = "part2-express-flask"
    key            = "flask-express-app/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
