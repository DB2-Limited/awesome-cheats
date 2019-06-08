<p align="left">
  <img src="./assets/aws/aws_logo.png" width=285>
</p>
<p align="left">
  <img src="./assets/kubernetes/kubernetes_logo.png" width=285>
</p>

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
  

**Amazon Web Services (AWS)** -  is a secure cloud services platform, offering compute power, database storage, content delivery and other functionality to help businesses scale and grow. In web industry AWS using for building sophisticated applications with increased flexibility, scalability and reliability.
[Learn more](https://docs.aws.amazon.com/index.html)

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
    
