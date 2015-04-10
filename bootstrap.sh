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

# Download and install hadoop
cd /usr/local
sudo wget https://archive.apache.org/dist/hadoop/core/hadoop-1.0.3/hadoop-1.0.3.tar.gz
sudo tar xzf hadoop-1.0.3.tar.gz
sudo ln -s /usr/local/hadoop-1.0.3 hadoop
sudo chown -R hduser:hadoop hadoop-1.0.3
sudo chown -R hduser:hadoop hadoop

# Copy over bashrc
sudo -u hduser cat /vagrant/bashrc >> /home/hduser/.bashrc

# Set up Hadoop
echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" >> /usr/local/hadoop/conf/hadoop-env.sh
echo "export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true" >> /usr/local/hadoop/conf/hadoop-env.sh

# Create tmp directory
sudo mkdir -p /app/hadoop/tmp
sudo chown hduser:hadoop /app/hadoop/tmp

# Hadoop configuration
sudo -u hduser cat /vagrant/core-site.xml > /usr/local/hadoop/conf/core-site.xml
sudo -u hduser cat /vagrant/mapred-site.xml > /usr/local/hadoop/conf/mapred-site.xml
sudo -u hduser cat /vagrant/hdfs-site.xml > /usr/local/hadoop/conf/hdfs-site.xml

# Hadoop filesystem
sudo -u hduser /usr/local/hadoop/bin/hadoop namenode -format

# Start Hadoop
sudo -u hduser /usr/local/hadoop/bin/start-all.sh
