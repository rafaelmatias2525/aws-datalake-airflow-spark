resource "aws_s3_bucket_object" "job_spark" {
  bucket = aws_s3_bucket.datalake-edc.id
  key    = "emr-code/pyspark/etl_job.py"
  acl    = "private"
  source = "../etl/etl_job.py"
  etag   = filemd5("../etl/etl_job.py")
  
  tags = {
    COURSE = "IGTI-EDC",
    TERRAFORM = "TRUE"
  }


}
