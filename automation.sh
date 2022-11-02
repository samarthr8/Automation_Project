#! /bin/bash

#creating variables
name="Samarth"
s3_bucket="upgrad-samarth"
timestamp=$(date '+%d%m%Y-%H%M%S')


#commant to update package
sudo apt update -y

#command to install apache
sudo apt install apache2

#command to start apache server
sudo systemctl start apache2

##Command to check whether apache2 is running or not, if not then start the service.
sudo systemctl status apache2

#Command to tar log files of apache2 server and move it to s3-bucket
sudo tar -c -v -f Samarth-httpd-logs-31102022-132441.tar /var/log/apache2/
aws s3 cp /tmp/Samarth-httpd-logs-31102022-132411.tar s3://$s3_bucket/



#Below code will create the inventoryfile for bookkeeping if file does not exists
size=$(sudo du -sh /tmp/Samarth-httpd-logs-31102022-132441.tar | awk '{print $1}')
if [ -e /var/www/html/inventory.html ]
then
echo "<br>httpd-logs &nbsp;&nbsp;&nbsp; ${timestamp} &nbsp;&nbsp;&nbsp; tar &nbsp;&nbsp;&nbsp; ${size}" >> /var/www/html/inventory.html
else
echo "<b>Log Type &nbsp;&nbsp;&nbsp;&nbsp; Date Created &nbsp;&nbsp;&nbsp;&nbsp; Type &nbsp;&nbsp;&nbsp;&nbsp; Size</b><br>" > /var/www/html/inventory.html
echo "<br>httpd-logs &nbsp;&nbsp;&nbsp; ${timestamp} &nbsp;&nbsp;&nbsp; tar &nbsp;&nbsp;&nbsp; ${size}" >> /var/www/html/inventory.html
fi

# Command to check if the cron file exists or not, if it doesn't exist then it will create the same
if  [ ! -f  /etc/cron.d/automation ]
then
	echo  "30 0 * * * \troot\t/root/Automation_Project/automation.sh" > /etc/cron.d/automation
fi

