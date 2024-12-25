import boto3

# Initialize the IAM client
iam_client = boto3.client('iam')

def find_users_without_mfa():
    users_without_mfa = []
    users = iam_client.list_users()['Users']

    for user in users:
        user_name = user['UserName']
        mfa_devices = iam_client.list_mfa_devices(UserName=user_name)['MFADevices']
        
        if not mfa_devices:
            users_without_mfa.append(user_name)
    
    return users_without_mfa

# Execute the function
users = find_users_without_mfa()
if users:
    print("Users without MFA enabled:", users)
else:
    print("All users have MFA enabled.")
