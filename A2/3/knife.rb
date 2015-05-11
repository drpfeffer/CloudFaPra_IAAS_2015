# EC2 sub-command
#
knife[:availability_zone] = "#{ENV['EC2_AVAILABILITY_ZONE']}"
knife[:aws_access_key_id] = "#{ENV['AWS_ACCESS_KEY_ID']}"
knife[:aws_secret_access_key] = "#{ENV['AWS_SECRET_ACCESS_KEY']}"
knife[:image] = "ami-4b471c7b"
knife[:flavor] = "t1.micro"
knife[:chef_mode] = "solo"
knife[:region] = "#{ENV['EC2_REGION']}"
knife[:ssh_user] = "ubuntu"
knife[:identity_file] = "/home/ebingefx/.ssh/cloudfapra.pem"
knife[:aws_ssh_key_id] = "Cloud_FaPra"
