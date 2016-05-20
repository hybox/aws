# aws

[![Launch Stack](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=hybox&templateURL=https://s3.amazonaws.com/hybox-deployment-artifacts/cloudformation/current/templates/stack.json)

## Full stack

1. Create the travis stack (below) and upload this repository into the bucket.

2. Create the application stack

```console
$ aws --region us-east-1 cloudformation create-stack --stack-name hybox --template-body file://templates/stack.json --capabilities CAPABILITY_IAM --parameters file://params/stack.json
```

## Travis deployment integration

Create a new IAM user, bucket, and access keys for the `.travis.yml` deployment step.

```console
$ aws --region us-east-1 cloudformation create-stack --stack-name travis --template-body file://templates/travis.json --capabilities CAPABILITY_IAM
```
