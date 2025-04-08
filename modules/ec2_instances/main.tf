resource "aws_instance" "public_ec2_az1" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_az1_id
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.instances_sg_id]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"            
      private_key = file(var.private_key_path)
      host        = self.public_ip    
    }

    inline = [
      
      "sudo yum update -y",
      "sudo yum install nginx -y",
      "sudo tee /etc/nginx/conf.d/proxy.conf > /dev/null <<EOF",
      "server {",
      "    listen 80;",
      "    server_name your_domain.com;",
      "    location / {",
      "        proxy_pass http://${var.private_lb_dns};",
      "        proxy_set_header Host \\$host;",
      "        proxy_set_header X-Real-IP \\$remote_addr;",
      "    }",
      "}",
      "EOF",
      "sudo service nginx restart"
    ]
  }

  tags = {
    Name = "Public_EC2_AZ1"
  }

  provisioner "local-exec" {
    command = "echo 'public_ip_1 ${self.public_ip}' >> all-ips.txt"
  }
}

resource "aws_instance" "public_ec2_az2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_az2_id
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.instances_sg_id]
  
 
  
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"            
      private_key = file(var.private_key_path)
      host        = self.public_ip    
    }

    inline = [
    
      "sudo yum update -y",
      "sudo yum install nginx -y",
      "sudo tee /etc/nginx/conf.d/proxy.conf > /dev/null <<EOF",
      "server {",
      "    listen 80;",
      "    server_name your_domain.com;", 
      "    location / {",
      "        proxy_pass http://${var.private_lb_dns};",
      "        proxy_set_header Host \\$host;",
      "        proxy_set_header X-Real-IP \\$remote_addr;",
      "    }",
      "}",
      "EOF",
      "sudo service nginx restart"
    ]
  }

  tags = {
    Name = "Public_EC2_AZ2"
  }

  provisioner "local-exec" {
    command = "echo 'public_ip_2 ${self.public_ip}' >> all-ips.txt"
  }
}

resource "aws_instance" "private_ec2_az1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_az1_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.instances_sg_id]


  provisioner "file" {
    source      = "/home/abdallah/Terraform_Project/web_server_1"
    destination = "/tmp/web_server_1"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.private_ip
      bastion_host       = aws_instance.public_ec2_az1.public_ip
      bastion_user       = "ec2-user"
      bastion_private_key = file(var.private_key_path)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd",
      "sudo cp -r /tmp/web_server_1/* /var/www/html/",
      "sudo chown -R apache:apache /var/www/html",
      "sudo systemctl restart httpd"
    ]
    connection {
      type                = "ssh"
      user                = "ec2-user"
      private_key         = file(var.private_key_path)
      host                = self.private_ip
      bastion_host        = aws_instance.public_ec2_az1.public_ip
      bastion_user        = "ec2-user"
      bastion_private_key = file(var.private_key_path)
    }
  }

  tags = {
    Name = "Private_EC2_AZ1"
  }

  provisioner "local-exec" {
    command = "echo 'private_ip_1 ${self.private_ip}' >> all-ips.txt"
  }

  depends_on = [aws_instance.public_ec2_az1]
}

resource "aws_instance" "private_ec2_az2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_az2_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.instances_sg_id]

  
  provisioner "file" {
    source      = "/home/abdallah/Terraform_Project/web_server_2"
    destination = "/tmp/web_server_2"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.private_ip
      bastion_host       = aws_instance.public_ec2_az1.public_ip
      bastion_user       = "ec2-user"
      bastion_private_key = file(var.private_key_path)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd",
      "sudo cp -r /tmp/web_server_2/* /var/www/html/",
      "sudo chown -R apache:apache /var/www/html",
      "sudo systemctl restart httpd"
    ]
    connection {
      type                = "ssh"
      user                = "ec2-user"
      private_key         = file(var.private_key_path)
      host                = self.private_ip
      bastion_host        = aws_instance.public_ec2_az2.public_ip
      bastion_user        = "ec2-user"
      bastion_private_key = file(var.private_key_path)
    }
  }

  tags = {
    Name = "Private_EC2_AZ2"
  }

  provisioner "local-exec" {
    command = "echo 'private_ip_2 ${self.private_ip}' >> all-ips.txt"
  }

  depends_on = [aws_instance.public_ec2_az2]
}
