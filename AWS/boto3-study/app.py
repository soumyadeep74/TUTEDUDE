import boto3
import os
from dotenv import load_dotenv

load_dotenv()

ACCESS_KEY_ID = os.getenv("ACCESS_KEY_ID")
SECRET_ACCESS_KEY = os.getenv("SECRET_ACCESS_KEY")
#create a s3 client
s3 = boto3.resource('s3', aws_access_key_id=ACCESS_KEY_ID, aws_secret_access_key=SECRET_ACCESS_KEY)

#BUCKET_NAME = 'course-bucket-2-tute'
#s3.create_bucket(Bucket=BUCKET_NAME, CreateBucketConfiguration={'LocationConstraint': 'ap-south-1'})
#upload a new file
for bucket in s3.buckets.all():
    location = s3.meta.client.get_bucket_location(Bucket=bucket.name)['LocationConstraint']
    print(bucket.name, location)
