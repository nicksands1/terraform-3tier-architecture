resource "aws_instance" "web" {
  ami                         = "ami-007868005aea67c54"
  instance_type               = "t2.micro"
  key_name                    = "nsands"
  subnet_id                   = aws_subnet.public[count.index].id
  vpc_security_group_ids      = [aws_security_group.allow_all_tls.id]
  associate_public_ip_address = true
  count                       = 2

  provisioner "file" {
    source      = "./nsands.pem"
    destination = "/home/ec2-user/nsands.pem"

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("./nsands.pem")
    }
  }
}

resource "aws_instance" "db" {
  ami                    = "ami-007868005aea67c54"
  instance_type          = "t2.micro"
  key_name               = "nsands"
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]

}
