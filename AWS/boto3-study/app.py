import boto3
import os
from dotenv import load_dotenv

load_dotenv()

ACCESS_KEY_ID = os.getenv("ACCESS_KEY_ID")
SECRET_ACCESS_KEY = os.getenv("SECRET_ACCESS_KEY")
#create a s3 client
s3 = boto3.resource('s3', aws_access_key_id=ACCESS_KEY_ID, aws_secret_access_key=SECRET_ACCESS_KEY)

BUCKET_NAME = 'course-bucket-2-tute'

#create new bucket
#s3.create_bucket(Bucket=BUCKET_NAME, CreateBucketConfiguration={'LocationConstraint': 'ap-south-1'})

#delete a bucket
#s3.Bucket(BUCKET_NAME).delete()

#download a file
#s3.Bucket(BUCKET_NAME).download_file('abc/def/a.txt.txt', 'b.txt')
#upload a new file
#for bucket in s3.buckets.all():
   # location = s3.meta.client.get_bucket_location(Bucket=bucket.name)['LocationConstraint']
   # print(bucket.name, location)
