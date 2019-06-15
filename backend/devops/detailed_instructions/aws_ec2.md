# Create cluster management instance

#### Open [EC2 AWS console](https://eu-central-1.console.aws.amazon.com/ec2/v2/home?region=eu-central-1#Home:)

<p align="center">
  <img src="../assets/detailed_instructions/aws_ec2/open_ec2.png" width=800>
</p>

#### Select area for you future instance

<p align="center">
  <img src="../assets/detailed_instructions/aws_ec2/select_area.png" width=800>
</p>

#### Press *Launch Instance* button

<p align="center">
  <img src="../assets/detailed_instructions/aws_ec2/press_launch_instance.png" width=800>
</p>

#### Choose AMI (use Ubuntu LTS Server)

<p align="center">
  <img src="../assets/detailed_instructions/aws_ec2/choose_ami.png" width=800>
</p>

#### Choose instance type (use t2.micro, for more detail read [Extra](#extra))

<p align="center">
  <img src="../assets/detailed_instructions/aws_ec2/choose_instance_type.png" width=800>
</p>

#### Press *Review and Launch*

<p align="center">
  <img src="../assets/detailed_instructions/aws_ec2/press_review_and_launch.png" width=800>
</p>

#### Press *Launch*

<p align="center">
  <img src="../assets/detailed_instructions/aws_ec2/press_create_instance.png" width=800>
</p>

#### Choose *Create a new key pair*
#### Add key pair name (e.g *<project_name_or_whatever_unique>_kubernetes*)
#### Press *Download key pair*
#### Press *Launch Instances*

<p align="center">
  <img src="../assets/detailed_instructions/aws_ec2/generate_key_pair.png" width=800>
</p>

#### Press *View Instances*

<p align="center">
  <img src="../assets/detailed_instructions/aws_ec2/view_instances.png" width=800>
</p>

#### Add you instance name (e.g. *kubernetes_machine*)
#### Copy and save instance IPv4 Public IP

<p align="center">
  <img src="../assets/detailed_instructions/aws_ec2/add_instance_name.png" width=800>
</p>

#### Go to folder with you key pair and run next commands to connect to your instance
```sh
chmod 400 <key_pair_name>.pem
ssh -i <key_pair_name>.pem ubuntu@<instance_ip_v4_address>
yes
sudo apt-get update
sudo apt-get upgrade
```

#### Extra
##### [Instance type info](https://aws.amazon.com/ec2/instance-types/)
##### [Instance price info](https://aws.amazon.com/ec2/pricing/on-demand/)