#! /bin/bash
sudo yum update -y
sudo  yum install httpd -y
sudo service httpd start
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
