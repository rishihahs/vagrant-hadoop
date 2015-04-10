# Install Java
sudo apt-get update
sudo apt-get install -y openjdk-7-jre openjdk-7-jdk

# Configure ssh
sudo -u vagrant ssh-keygen -t rsa -N "" -f /home/vagrant/.ssh/id_rsa
sudo -u vagrant cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
sudo -u vagrant ssh-keyscan -H localhost >> /home/vagrant/.ssh/known_hosts

# Download and install hadoop
cd /usr/local
sudo wget https://archive.apache.org/dist/hadoop/core/hadoop-1.0.3/hadoop-1.0.3.tar.gz
sudo tar xzf hadoop-1.0.3.tar.gz
sudo ln -s /usr/local/hadoop-1.0.3 hadoop
sudo chown -R vagrant:vagrant hadoop-1.0.3
sudo chown -R vagrant:vagrant hadoop

# Copy over bashrc
sudo -u vagrant cat /vagrant/bashrc >> /home/vagrant/.bashrc

# Set up Hadoop
echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" >> /usr/local/hadoop/conf/hadoop-env.sh
echo "export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true" >> /usr/local/hadoop/conf/hadoop-env.sh

# Create tmp directory
sudo mkdir -p /app/hadoop/tmp
sudo chown vagrant:vagrant /app/hadoop/tmp

# Hadoop configuration
sudo -u vagrant cat /vagrant/core-site.xml > /usr/local/hadoop/conf/core-site.xml
sudo -u vagrant cat /vagrant/mapred-site.xml > /usr/local/hadoop/conf/mapred-site.xml
sudo -u vagrant cat /vagrant/hdfs-site.xml > /usr/local/hadoop/conf/hdfs-site.xml

# Hadoop filesystem
sudo -u vagrant /usr/local/hadoop/bin/hadoop namenode -format

# Start Hadoop
sudo -u vagrant /usr/local/hadoop/bin/start-all.sh
