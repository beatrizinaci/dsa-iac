module "dsa_ec2_instances" {
    source = "./modules/ec2-instances"

    instance_count = 2
    ami_id = "ami-0a5a5b7e2278263e5"
    instance_type = "t2.micro"
    subnets = ["subnet-05b07aacbec544c8f"]
}

module "dsa_s3_buckets" {
    source = "./modules/s3-buckets"
    bucket_name = "dsa-s3-bucket"
    tags = {
        Name = "DSA S3 Bucket"
    }
}