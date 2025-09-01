resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24" 
  availability_zone = "us-east-1a"
}

# EC2 Instance
resource "aws_instance" "example" {
  ami           = "ami-00ca32bbc84273381" 
  instance_type = var.instance_type
  subnet_id     = aws_subnet.main.id

  tags = {
    Name = "EC2_Instance"
  }
}

# EBS Volume (same AZ as EC2 subnet)
resource "aws_ebs_volume" "extra" {
  availability_zone = aws_subnet.main.availability_zone
  size              = 1 # size in GB

  tags = {
    Name = "Mounted_Volume"
  }
}

# Attach EBS Volume to EC2
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh" # Linux device mapping
  volume_id   = aws_ebs_volume.extra.id
  instance_id = aws_instance.example.id
}
