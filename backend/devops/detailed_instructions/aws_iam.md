### IAM
#####Open [IAM AWS Console](https://console.aws.amazon.com/iam/home?region=eu-central-1#/users)

<p align="center">
  <img src="../assets/detailed_instructions/aws_iam/console.png" width=800>
</p>

Press the `Add user` button

<p align="center">
  <img src="../assets/detailed_instructions/aws_iam/add_user_start.png" width=800>
</p>

Enter username `kops`, choose the `Access type` - `Programmatic access` and press `Next:Premissions` button

<p align="center">
  <img src="../assets/detailed_instructions/aws_iam/choose_name.png" width=800>
</p>

Press `Next:Tags` button

<p align="center">
  <img src="../assets/detailed_instructions/aws_iam/press_tags.png" width=800>
</p>

Press `Next:Review` button

<p align="center">
  <img src="../assets/detailed_instructions/aws_iam/press_review.png" width=800>
</p>

Press `Create user` button

<p align="center">
  <img src="../assets/detailed_instructions/aws_iam/add_user_finish.png" width=800>
</p>

Copy the `Access key ID` and `Secret access key` and press `Close` button

<p align="center">
  <img src="../assets/detailed_instructions/aws_iam/api_and_key.png" width=800>
</p>

Choose the `kops` user

<p align="center">
  <img src="../assets/detailed_instructions/aws_iam/choose_kops_user.png" width=800>
</p>

Press `Add permissions` button

<p align="center">
  <img src="../assets/detailed_instructions/aws_iam/press_add_permissions.png" width=800>
</p>

Choose `Attach existing policies directly`, only the `Administrator access` and press `Next:Review` button

<p align="center">
  <img src="../assets/detailed_instructions/aws_iam/choose_permissions.png" width=800>
</p>

Press `Add permissions` button

<p align="center">
  <img src="../assets/detailed_instructions/aws_iam/create_permissions.png" width=800>
</p>