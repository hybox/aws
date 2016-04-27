# aws

## Zookeeper

```console
$ aws --region us-east-1 cloudformation create-stack --stack-name zookeeper --template-body file://stacks/zookeeper.json --capabilities CAPABILITY_IAM --parameters file://params/zookeeper.json
```
