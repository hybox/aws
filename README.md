# aws

## Zookeeper

```console
$ aws --region us-east-1 cloudformation create-stack --stack-name zookeeper --template-body file://stacks/zookeeper.json --capabilities CAPABILITY_IAM --parameters file://params/zookeeper.json
```

## Solr

```console
$ aws --region us-east-1 cloudformation create-stack --stack-name solr --template-body file://stacks/solr.json --capabilities CAPABILITY_IAM # optional: --parameters ParameterKey=ZookeeperHosts,ParameterValue=1.2.3.4:2181,5.6.7.8:2181,9.8.7.6:2181
```

## Travis deployment integration

Create a new IAM user, bucket, and access keys for the `.travis.yml` deployment step.

```console
$ aws --region us-east-1 cloudformation create-stack --stack-name travis --template-body file://stacks/travis.json --capabilities CAPABILITY_IAM
```