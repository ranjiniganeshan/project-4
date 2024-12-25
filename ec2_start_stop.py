import boto3

# Initialize the EC2 client
ec2_client = boto3.client('ec2', region_name='us-west-2')

def stop_running_instances():
    instances = ec2_client.describe_instances(
        Filters=[{'Name': 'instance-state-name', 'Values': ['running']}]
    )

    instance_ids = [
        instance['InstanceId']
        for reservation in instances['Reservations']
        for instance in reservation['Instances']
    ]
    
    if instance_ids:
        ec2_client.stop_instances(InstanceIds=instance_ids)
        print(f"Stopped instances: {instance_ids}")
    else:
        print("No running instances found.")

# Execute the function
stop_running_instances()
