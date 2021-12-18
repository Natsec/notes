# Cloud Security

Ressources :
- https://hackingthe.cloud/

## AWS (Amazon Web Service)

### S3 (Simple Storage Service)

Amazon S3 (Simple Storage Service) is their hosted object storage service. Objects are stored in Buckets. Buckets use a global namespace :
```bash
http://bucketname.s3.amazonaws.com/filename.ext
# or
http://s3.amazonaws.com/bucketname/filename.ext
```

Commandes :
```bash
# Lister le contenu d'un bucket
curl http://irs-form-990.s3.amazonaws.com/
aws s3 ls s3://irs-form-990/ --no-sign-request  # --no-sign-request for no auth

# Télécharger l'objet d'un bucket
curl http://irs-form-990.s3.amazonaws.com/201101319349101615_public.xml
aws s3 cp s3://irs-form-990/201101319349101615_public.xml . --no-sign-request
```

In Amazon S3, Object permissions are different from Bucket permissions. Bucket permissions allow you to list the objects in a bucket, while the object's permissions will enable you to download the object.

2 levels of ACL :
- Anyone (understand unauthenticated)
- AuthenticatedUsers (understand any AWS client)

For 2 operations :
- list content of bucket
- download object from bucket

|      ACL name      | List bucket                   | Download object               |
| :----------------: | ----------------------------- | ----------------------------- |
|       Anyone       | `aws s3 ls --no-sign-request` | `aws s3 cp --no-sign-request` |
| AuthenticatedUsers | `aws s3 ls`                   | `aws s3 cp`                   |

### AWS IAM (Identity Access Management)

IAM Access Keys consist of :
- Access Key ID (username) : begin with `AKIA` and are 20 char long
- Secret Access Key (pass) : 40 char long

Short-term credentials consist of :
- Access Key ID (username) : begin with `ASIA`
- Secret Access Key (pass)
- Session Token

ARN is Amazon's way of generating a unique identifier for all resources in the AWS Cloud. It consists of multiple strings separated by colons.
The format is `arn:aws:<service>:<region>:<account_id>:<resource_type>/<resource_name>`.

Commandes :
```bash
# Add creds to AWS profile
aws configure --profile PROFILENAME
# This command will add entries to the .aws/config and .aws/credentials files in your user's home directory

# Use profile
aws s3 ls --profile PROFILENAME
# ProTip: Never store a set of access keys in the default profile. Doing so forces you to always specify a profile and never accidentally run a command against an account you don't intend to.

####################
# Other common AWS reconnaissance techniques
####################

# Finding the Account ID belonging to an access key
aws sts get-access-key-info --access-key-id AKIAEXAMPLE
# Determining the Username the access key you are using belongs to
aws sts get-caller-identity --profile PROFILENAME
# Listing all the EC2 instances running in an account
aws ec2 describe-instances --output text --profile PROFILENAME
# Listing all the EC2 instances running in an account in a different region
aws ec2 describe-instances --output text --region us-east-1 --profile PROFILENAME
# Listing secrets belonging to an account
aws secretsmanager list-secrets --profile PROFILENAME
# Retrieving secret value
aws secretsmanager get-secret-value --secret-id HR-Password
```
