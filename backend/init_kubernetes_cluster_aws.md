# Init Kubernetes cluster on AWS

## Setup AWS

### IAM
- Open [IAM AWS Console](https://console.aws.amazon.com/iam/home?region=eu-central-1#/users)
- Press the `Add user` button
- Enter username `kops`
- Choose the `Access type` - `Programmatic access`
- Press `Next:Premissions` button
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

### S3
- Open [S3 AWS Console](https://s3.console.aws.amazon.com/s3/home?region=eu-central-1)
- Press `Create bucket` button
- Enter bucket name `kops-state-<project_name_or_whatever_unique>` (e.g. `kops-state-r4nd0m`)

### Route53
- Open [Route53 AWS Console](https://console.aws.amazon.com/route53/home?region=eu-central-1#hosted-zones)
- Press `Create Hosted Zone`
- Enter the domain name `<your_domain_name>` (e.g. `example.com`)
- Press `Create` button

## Setup domain provider
When you create `Route53 HostedZone` you will get 4 NameServers:
```
ns-xxx.awsdns-xx.org.
ns-xxx.awsdns-xx.co.uk.
ns-xxx.awsdns-xx.net.
ns-xxx.awsdns-xx.com.
```
You need change the default NS in you domain provider dashboard to that provided values.

## Setup machine(AWS EC2) for cluster management
### awscli
```bash
apt-get update
apt-get install python-pip
pip install awscli
aws configure
```

### kubectl
```bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin/
```

### kops
```bash
curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops
mv kops /usr/local/bin/
```

### ssh keys
```bash
ssh-keygen -f .ssh/id_rsa
```

## Init cluster

```bash
kops create cluster --name=<your_domain_name> --state=s3://kops-state-<project_name_or_whatever_unique> --zones=<zone_name> --node-count=<node_count> --node-size=<node_size> --master-size=<master_size> --dns-zone=<your_domain_name>
kops update cluster <your_domain_name> --yes --state=s3://kops-state-<project_name_or_whatever_unique>
```

- [Zones reference](https://gist.github.com/neilstuartcraig/0ccefcf0887f29b7f240)
- [Sizes reference](https://aws.amazon.com/ec2/pricing/reserved-instances/pricing/)

Wait until all nodes will be ready by periodic check output of the `kops validate cluster`
