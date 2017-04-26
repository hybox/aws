# aws

[![Launch Stack](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=hybox&templateURL=https://s3.amazonaws.com/hybox-deployment-artifacts/cloudformation/current/templates/stack.json)

These AWS CloudFormation templates create a full application stack for a multitenant-ready  [Hydra-in-a-Box](https://github.com/projecthydra-labs/hyku) application, including:

  - a dedicated [Amazon Virtual Private Cloud](https://aws.amazon.com/vpc) (VPC) for the stack components, with public and private subnets across 3 Availability Zones, and a bastion host providing SSH access for system administrators;
  - a multi-node SolrCloud cluster backed by a multi-node zookeeper ensemble;
  - a PostgreSQL database with a multi-availability zone hot spare;
  - a (single node) Fedora 4 server;
  - and a Rails application stack, with auto-scaling webapp and worker tiers and continuous deployment of the application code.

![AWS Stack Diagram](https://cloud.githubusercontent.com/assets/111218/16077301/e8a0dc6c-32ef-11e6-80b4-e9e74c18973e.png)


## Creating the full stack

0. Select an AWS region, e.g.:

```
$ AWS_DEFAULT_REGION=us-east-1
```

1. Create or import an [EC2 key-pair](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html) for that region.

2. Create a [public hosted zone](http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/CreatingHostedZone.html); the web application will automatically manage DNS entries in this zone.

3. Create an [S3 bucket](http://docs.aws.amazon.com/AmazonS3/latest/user-guide/create-bucket.html) to be used for the persistent storage of binary content.

4. Create an [IAM user](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html) and [give that user permission](https://aws.amazon.com/blogs/security/writing-iam-policies-how-to-grant-access-to-an-amazon-s3-bucket/) to access the S3 bucket created in the previous step. Make sure to capture the new user's API access credentials.

5. Copy the `params/defaults.json` template to a new environment-specific file, populating the parameter values as appropriate for your environment. This repo ignores a local file named `params/private.json` where secret params can be set. Make sure to set values for at least these parameters (the default settings, while insecure, will work for the other parameters, and should suffice for development purposes):
   - `KeyName`: the name of the key-pair created in step 1
   - `PublicZoneName`: the name of the hosted zone created in step 2 (with a trailing period)
   - `DatabasePassword` and `FcrepoDatabasePassword`: password for Hyku and Fedora databases
   - `FcrepoS3BucketName`: the name of the S3 bucket created in step 3
   - `FcrepoS3AccessKey` and `FcrepoS3SecretKey`: API credentials for user created in step 4
   - `SecretKeyBase`: rails key generation base

6. Create the full application stack:

```console
$ aws --region $AWS_DEFAULT_REGION cloudformation create-stack --stack-name hybox --template-body https://s3.amazonaws.com/hybox-deployment-artifacts/cloudformation/current/templates/stack.json --capabilities CAPABILITY_IAM --parameters file://params/private.json
```

You can also create (or update) your application from branches of the cloudformation repository:

```console
$ aws --region $AWS_DEFAULT_REGION cloudformation create-stack --stack-name hybox --template-body https://s3.amazonaws.com/hybox-deployment-artifacts/cloudformation/branch/branch-name/templates/stack.json --capabilities CAPABILITY_IAM --parameters file://params/my-hybox-environment.json
```

You can also deploy branches of the hybox application repository by setting the `WebappS3Key` parameter for your stack to point at the branch-specific deployment artifact (e.g. `hyku/branch/branch-name/hyku.zip`)

The stack will spin up in the following order:

```console
|- stack
   |- mail
   |- slack
   |- vpc
      |- securitygroups
          |- bastion
          |- zookeeper
              |- solr
          |- redis
          |- postgres
          |- postgres-fedora
              |- fcrepo
                  |- application
                      |- workers
                      |- webapp
                          |- codepipeline

```

## Travis deployment integration

The AWS CloudFormation stack must be deployed into an S3 bucket for CloudFormation to correctly resolve sub-stack references. The `templates/travis.json` stack will bootstrap the necessary buckets, IAM user, and access keys to support continuous deployment from both this CloudFormation repository and the Hydra-in-a-Box application repository.

This bootstrapping is already provided for the main repositories, but if you deploy a fork of this stack, you may need to create this stack and configure continuous deployment for your forks. These files will expire from S3 after a period of time, so pushing a change to the repository may be required to republish the templates.

```console
$ aws --region $AWS_DEFAULT_REGION cloudformation create-stack --stack-name travis --template-body file://templates/travis.json --capabilities CAPABILITY_IAM
```

You will need the outputs from this stack to create [deploy steps](https://docs.travis-ci.com/user/deployment/s3 ) for these repositories.
