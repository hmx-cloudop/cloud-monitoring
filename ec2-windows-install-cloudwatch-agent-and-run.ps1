cd C:\Users\Administrator

$CWFILE="C:\Program Files\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-ctl.ps1"

if (Test-Path $CWFILE -PathType leaf)
  {
  "File does exist"
  }

else
  {
 & wget https://raw.githubusercontent.com/daon-moon/testcw/master/amazon-cloudwatch-agent-mem-windows.json -OutFile ./amazon-cloudwatch-agent-windows.json

 & wget https://s3.ap-northeast-2.amazonaws.com/amazoncloudwatch-agent-ap-northeast-2/windows/amd64/latest/amazon-cloudwatch-agent.msi -OutFile ./amazon-cloudwatch-agent.msi   
     
 start-sleep -seconds 1
  
 msiexec /i amazon-cloudwatch-agent.msi

 start-sleep -seconds 30

}

if(Test-Path $CWFILE -PathType leaf){
  & Copy-Item -Path "C:\Users\Administrator\amazon-cloudwatch-agent-windows.json" -Destination "C:\Program Files\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-windows.json" -Force 
  
  & "C:\Program Files\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-ctl.ps1" -m ec2 -a stop
  
  & "C:\Program Files\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-ctl.ps1" -a fetch-config -m ec2 -c "file:C:\Program Files\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-windows.json" -s    
}
else{
 "Check again"
}
