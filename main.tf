# --- Existing EC2 instance ---
resource "aws_instance" "my_instance" {
  ami           = "ami-04c913012f8977029"  
  instance_type = "t2.micro"
  subnet_id     = "subnet-0c4b5724679738508"       
  tags = {
    Name = "eric-webapp"
  }
}

# --- Create 1 GB EBS Volume ---
resource "aws_ebs_volume" "my_volume" {
  availability_zone = aws_instance.my_instance.availability_zone  
  size              = 1  # Size in GiB
  tags = {
    Name = "eric_1GB"
  }
}

# --- Attach the EBS Volume to the EC2 instance ---
resource "aws_volume_attachment" "my_attachment" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.my_volume.id
  instance_id = aws_instance.my_instance.id
}