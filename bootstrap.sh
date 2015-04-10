# Install Java
sudo apt-get update
sudo apt-get install -y openjdk-7-jre openjdk-7-jdk

# Add hadoop group and user
sudo addgroup hadoop
sudo useradd -g hadoop -d /home/hduser -m -s /bin/bash -p $(echo "hadoop" | openssl passwd -1 -stdin) hduser

# Configure ssh
sudo -u hduser ssh-keygen -t rsa -N "" -f /home/hduser/.ssh/id_rsa
sudo -u hduser cat /home/hduser/.ssh/id_rsa.pub >> /home/hduser/.ssh/authorized_keys
sudo -u hduser ssh-keyscan -H localhost >> /home/hduser/.ssh/known_hosts
