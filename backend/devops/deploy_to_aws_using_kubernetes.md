# Deploy to AWS using Kubernetes
##### Table of Contents

- [Base concepts](#)
  - [AWS](#)
  - [Kubernetes](#)
- [Setup AWS](#)
  - [IAM](#)
  - [S3 bucket](#)
  - [Route53](#)
  - [Setup domain provider](#)
- [Setup cluster management instance](#)
  - [Create cluster management instance](#)
  - [Install and configure awscli](#)
  - [Install kubectl](#)
  - [Install kops](#)
  - [Generate ssh keys](#)
  - [Init cluster](#)
- [Setup kubernetes dashboard](#)
  
<p align="left">
  <img src="./assets/aws/aws_logo.png" width=285>
</p>

**Amazon Web Services (AWS)** -  is a secure cloud services platform, offering compute power, database storage, content delivery and other functionality to help businesses scale and grow. In web industry AWS using for building sophisticated applications with increased flexibility, scalability and reliability.
[Learn more](https://docs.aws.amazon.com/index.html)

<p align="left">
  <img src="./assets/kubernetes/kubernetes_logo.png" width=285>
</p>

**Kubernetes** - is an open-source container-orchestration system for automating deployment, scaling and management of containerized applications.
[Learn more](https://kubernetes.io/docs/home/)

## Setup AWS
### IAM
- Open [IAM AWS Console](https://console.aws.amazon.com/iam/home?region=eu-central-1#/users)
- Press the `Add user` button
- Enter username `kops`
- Choose the `Access type` - `Programmatic access`
- Press `Next:Premissions` button
- Press `Next:Tags` button
- Press `Next:Review` button
- Press `Create user` button
- Copy the `Access key ID` and `Secret access key`
- Press `Close` button
- Choose the `kops` user
- Press `Add permissions` button
- Choose `Attach existing policies directly`
- Choose only the `Administrator access`
- Press `Next:Review` button
- Press `Add permissions` button

[More detailed instruction](./detailed_instructions/aws_iam.md) 
    
### S3 bucket
- Open [S3 AWS Console](https://s3.console.aws.amazon.com/s3/home?region=eu-central-1)
- Press `Create bucket` button
- Enter bucket name `kops-state-<project_name_or_whatever_unique>` (e.g. `kops-state-r4nd0m`)

[More detailed instruction](./detailed_instructions/aws_s3_bucket.md)

### Route53
- Open [Route53 AWS Console](https://console.aws.amazon.com/route53/home?region=eu-central-1#hosted-zones)
- Press `Create Hosted Zone`
- Enter the domain name `<your_domain_name>` (e.g. `example.com`)
- Press `Create` button

[More detailed instruction](./detailed_instructions/aws_route53.md)

## Setup domain provider
When you create `Route53 HostedZone` you will get 4 NameServers:
```
ns-xxx.awsdns-xx.org.
ns-xxx.awsdns-xx.co.uk.
ns-xxx.awsdns-xx.net.
ns-xxx.awsdns-xx.com.
```
You need change the default NS in you domain provider dashboard to that provided values.

### Setup cluster management instance
## Create cluster management instance
- Open [EC2 AWS console](https://eu-central-1.console.aws.amazon.com/ec2/v2/home?region=eu-central-1#Home:)
- Select area for you future instance
- Press `Launch Instance` button
- Choose AMI (by default use Ubuntu LTS Server)
- Choose instance type (by default use t2.micro)
- Press `Review and Launch`
- Press `Launch`
- Choose `Create a new key pair`
- Add key pair name (e.g `<project_name_or_whatever_unique>_kubernetes`)
- Press `Download key pair`
- Press `Launch Instances`
- Press `View Instances`
- Add you instance name (e.g. `kubernetes_machine`)
- Copy and save instance IPv4 Public IP
- Go to folder with you key pair
- Run command `chmod 400 <key_pair_name>.pem`
- Run command `ssh -i <key_pair_name>.pem ubunru@<instance_ip_v4_address>`
- Input `yes`
- Run command `sudo apt-get update`
- Run command `sudo apt-get upgrade`

[More detailed instruction](./detailed_instructions/aws_ec2.md)
