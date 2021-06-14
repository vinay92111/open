provider "aws" {
  region     = "us-east-2"
  access_key = "AK##############"
  secret_key = "9sbA####################"
}


resource "aws_key_pair" "newkey" {
  key_name   = "newkey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgtn7p2bTvXeDo+0MbmKyumRed6ysDYTazmH30RobWalRRfT9K4/MkEPvXg/sQCRlf2xqenlS9jux9kh68cO3Fcxc8VGQ83hJaLWj4Tj/tLC0/h34STPJhE8IydnPhlxHCw4tybYyVNYscG3jHIrzktsGjdNI1WavRXsfDyCLGmQCVzW4RbhDvuhVU+7GAadARSCf4FduDa3/wnI2qfWmmx3XMWS/8jRww2l5+/H9cvEeQwu5nt7bBUGFpXHNiUKqJq+dNZrzUkrU+M6Himm3471ZUy+Yt3t414tV8NS3NQv4cVwK/e5ydGstClTQCQ/8kA3EfUvYXlCELfThBzvhP root@ip-172-31-36-104.us-east-2.compute.internal"

}

resource "aws_instance" "myinst" {
  ami           = "ami-0d8d212151031f51c" # us-east-2
  instance_type = "t2.micro"
  key_name      = "newkey"
  tags = {
    Name = "ansible-Instance"
      }
provisioner "remote-exec" {
inline =  [
     "echo 'build ssh connection'"
]
connection {
   host = self.public_ip
   type = "ssh"
   user = "ec2-user"
   private_key = file("./newkey")
}
}

provisioner "local-exec" {
    command = "ansible-playbook -i  ${self.public_ip}, --private-key newkey play.yml"
}
}
