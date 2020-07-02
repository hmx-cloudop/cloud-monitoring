# Install CloudWatch Agent with preconfigure metrics and logs to collect
# Using configuration file hosted on S3

#!/bin/bash

cd /home/ubuntu/

CWFILE=/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl 
if test -f "$CWFILE"; then
    echo "$CWFILE exist"
else
   wget https://s3.ap-northeast-2.amazonaws.com/amazoncloudwatch-agent-ap-northeast-2/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
   sudo dpkg -i -E ./amazon-cloudwatch-agent.deb	
fi

wget https://raw.githubusercontent.com/daon-moon/testcw/master/amazon-cloudwatch-agent-mem-linux.json
#aws s3 cp s3://hmx-cloudop-fileshare-01/cloudwatch-agent-config/amazon-cloudwatch-agent-mem-linux.json /home/ubuntu/

sleep 5

sudo cp /home/ubuntu/amazon-cloudwatch-agent-mem-linux.json /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a stop

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s
