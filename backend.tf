terraform {
    backend "s3" {
        bucket = "terraform-demo-state-files"
        region = "us-east-1"
        key    = "state"
    }
}