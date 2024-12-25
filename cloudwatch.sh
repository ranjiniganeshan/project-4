#!/bin/bash

# Update system packages
echo "Updating system packages..."
sudo yum update -y

# Install Amazon CloudWatch Agent
echo "Installing Amazon CloudWatch Agent..."
sudo yum install -y amazon-cloudwatch-agent

# Create CloudWatch Agent configuration
echo "Creating CloudWatch Agent configuration..."
sudo mkdir -p /opt/aws/amazon-cloudwatch-agent/etc
sudo tee /opt/aws/amazon-cloudwatch-agent/etc/config.json > /dev/null <<EOF
{
    "agent": {
        "metrics_collection_interval": 60,
        "logfile": "/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log"
    },
    "logs": {
        "logs_collected": {
            "files": {
                "collect_list": [
                    {
                        "file_path": "/var/log/messages",
                        "log_group_name": "EC2-Logs",
                        "log_stream_name": "{instance_id}-messages"
                    },
                    {
                        "file_path": "/var/log/secure",
                        "log_group_name": "EC2-Logs",
                        "log_stream_name": "{instance_id}-secure"
                    }
                ]
            }
        }
    }
}
EOF

# Apply the CloudWatch Agent configuration
echo "Applying CloudWatch Agent configuration..."
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config \
    -m ec2 \
    -c file:/opt/aws/amazon-cloudwatch-agent/etc/config.json \
    -s

# Verify the status of the CloudWatch Agent
echo "Verifying CloudWatch Agent status..."
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a status

# Output success message
echo "CloudWatch Agent setup complete!"

