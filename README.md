# aws

## Full stack

1. Create the travis stack (below) and upload this repository into the bucket.

2. Create the zookeeper stack

```console
$ aws --region us-east-1 cloudformation create-stack --stack-name zookeeper --template-body file://stacks/zookeeper.json --capabilities CAPABILITY_IAM --parameters file://params/zookeeper.json
```

Note the generated zookeeper hosts, and pass it through as the application stack `ZookeeperHosts` parameter.

3. Create the application stack

```console
$ aws --region us-east-1 cloudformation create-stack --stack-name hybox --template-body file://stacks/application.json --capabilities CAPABILITY_IAM --parameters file://params/application.json
```

## Travis deployment integration

Create a new IAM user, bucket, and access keys for the `.travis.yml` deployment step.

```console
$ aws --region us-east-1 cloudformation create-stack --stack-name travis --template-body file://stacks/travis.json --capabilities CAPABILITY_IAM
```
