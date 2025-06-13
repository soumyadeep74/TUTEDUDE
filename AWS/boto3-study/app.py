import boto3

#create a s3 client
s3 = boto3.client('s3')

#upload a new file
for bucket in s3.buckets.all():
    print(bucket.name)
