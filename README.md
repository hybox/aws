# aws

## Zookeeper

```console
$ aws --region us-east-1 cloudformation create-stack --stack-name zookeeper --template-body file://stacks/zookeeper.json --capabilities CAPABILITY_IAM --parameters file://params/zookeeper.json
```


## Travis deployment integration

Create a new IAM user, bucket, and access keys for the `.travis.yml` deployment step.

```console
$ aws --region us-east-1 cloudformation create-stack --stack-name travis --template-body file://stacks/travis.json --capabilities CAPABILITY_IAM
```