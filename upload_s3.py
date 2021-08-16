# imports
import boto3
from utils.logger import get_logger

# get a logger
logger = get_logger()

# Upload a file to S3
s3_client = boto3.client('s3')
file_path = "../data/test/logo512.png"
bucket_name = "datalake-edc-raw-data"
object_name = "test-area/logo512.png"

try:
    logger.info("Uploading file {} to {} on bucket {}".format(file_path, object_name, bucket_name))
    response = s3_client.upload_file(file_path, bucket_name, object_name)
    logger.info("File uploaded with success!")
except Exception as e:
    logger.error(e)