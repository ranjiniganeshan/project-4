#!/bin/bash
# Update and install required packages
sudo yum update -y
sudo yum install -y amazon-cloudwatch-agent

# Configure the CloudWatch agent
cat <<EOF > /opt/aws/amazon-cloudwatch-agent/bin/config.json
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
                        "log_stream_name": "{instance_id}"
                    }
                ]
            }
        }
    }
}
EOF

# Start the CloudWatch agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config \
    -m ec2 \
    -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json \
    -s
