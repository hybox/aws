# aws

## Zookeeper

```console
$ aws --region us-east-1 cloudformation create-stack --stack-name zookeeper --template-body file://stacks/zookeeper.json --capabilities CAPABILITY_IAM --parameters file://params/zookeeper.json
```

## Solr

```console
$ aws --region us-east-1 cloudformation create-stack --stack-name solr --template-body file://stacks/solr.json --capabilities CAPABILITY_IAM --parameters file://params/solr.json
```

## Fedora

```console
$ aws --region us-east-1 cloudformation create-stack --stack-name fcrepo --template-body file://stacks/fcrepo.json --capabilities CAPABILITY_IAM --parameters file://params/fcrepo.json
```

## Travis deployment integration

Create a new IAM user, bucket, and access keys for the `.travis.yml` deployment step.

```console
$ aws --region us-east-1 cloudformation create-stack --stack-name travis --template-body file://stacks/travis.json --capabilities CAPABILITY_IAM
```
