import boto3

# Initialize the EC2 client
ec2_client = boto3.client('ec2', region_name='ap-south-1')

def find_unattached_volumes():
    volumes = ec2_client.describe_volumes(
        Filters=[{'Name': 'status', 'Values': ['available']}]
    )['Volumes']

    volume_ids = [volume['VolumeId'] for volume in volumes]
    
    if volume_ids:
        print("Unattached volumes:", volume_ids)
    else:
        print("No unattached volumes found.")

# Execute the function
find_unattached_volumes()
