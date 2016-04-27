# aws

## Zookeeper

```console
$ aws --region us-east-1 cloudformation create-stack --stack-name zookeeper --template-body file://zookeeper.json --capabilities CAPABILITY_IAM --parameters  ParameterKey=SubnetID,ParameterValue=subnet-4eb52273,subnet-14a3553e,subnet-7d2cd625,subnet-ed0aaa9b
```
