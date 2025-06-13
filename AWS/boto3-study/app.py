import boto3
ACCESS_KEY_ID='AKIAUP5E6PV6FQ6KLLGC'
SECRET_ACCESS_KEY='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'
#create a s3 client
s3 = boto3.resource('s3', aws_access_key_id=ACCESS_KEY_ID, aws_secret_access_key=SECRET_ACCESS_KEY)

#upload a new file
for bucket in s3.buckets.all():
    print(bucket.name)
