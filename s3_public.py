import boto3

# Initialize the S3 client
s3_client = boto3.client('s3')

def list_public_buckets():
    buckets = s3_client.list_buckets()['Buckets']
    public_buckets = []

    for bucket in buckets:
        bucket_name = bucket['Name']
        acl = s3_client.get_bucket_acl(Bucket=bucket_name)
        for grant in acl['Grants']:
            if 'AllUsers' in grant['Grantee'].get('URI', ''):
                public_buckets.append(bucket_name)
                break

    return public_buckets

# Execute the function
public_buckets = list_public_buckets()
if public_buckets:
    print("Buckets with public access:", public_buckets)
else:
    print("No buckets with public access found.")
