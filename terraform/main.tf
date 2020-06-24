resource "aws_key_pair" "sshkey" {
  key_name   = "${var.stack}-key"
  public_key = "${file("${var.ssh_key}")}"
}

resource "aws_instance" "ec2" {
  ami           = "ami-063246c1e8988282c"
  instance_type = "${var.vm_size}"
  subnet_id = "${aws_subnet.subnet[0].id}"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  key_name = "${aws_key_pair.sshkey.key_name}"
  tags = {
    Name = "${var.stack}-growlerfriday"
  }
}
