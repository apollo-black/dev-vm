#!/bin/bash

echo "# -------------------------------- #"
echo "#      Apollo Ruby VM Install      #"
echo "# -------------------------------- #"

mkdir /home/vagrant/downloads

sudo su -c "echo \"vagrant ALL=(ALL) NOPASSWD:ALL\" > /etc/sudoers.d/vagrant"

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get -y install wget ca-certificates gcc g++ gnupg2 make software-properties-common \
  git-core curl build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev libcurl4-openssl-dev \
  libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libffi-dev libpq-dev tcl8.5 libexpat1-dev gettext unzip \
  libmagick++-dev libv8-dev libffi-dev libpulse0 imagemagick

echo "# -------------------------------- #"
echo "#         Setting SSH Keys         #"
echo "# -------------------------------- #"

mkdir -p /home/vagrant/.ssh
chmod 0700 /home/vagrant/.ssh
mv ./ssh/vagrant.pub /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
sudo chown -R vagrant:root /home/vagrant/.ssh
sudo apt-get install -y openssh-server
echo 'AuthorizedKeysFile %h/.ssh/authorized_keys' | sudo tee --append /etc/ssh/sshd_config > /dev/null
sudo service ssh restart

echo "# -------------------------------- #"
echo "#    Installing Guest Additions    #"
echo "# -------------------------------- #"

sudo mkdir /cdrom
sudo mount /dev/cdrom /cdrom
cd /cdrom
sudo apt-get install -y dkms build-essential linux-headers-generic linux-headers-$(uname -r)
sudo su -c "./VBoxLinuxAdditions.run"

echo "# -------------------------------- #"
echo "#         Installing Ruby          #"
echo "# -------------------------------- #"

echo "gem: --no-ri --no-rdoc" > ~/.gemrc
cd /home/vagrant/downloads && wget http://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.1.tar.gz -O ruby.tar.gz
cd /home/vagrant/downloads && tar xzf ruby.tar.gz
cd /home/vagrant/downloads/ruby-2.6.1 && ./configure -prefix=$HOME
cd /home/vagrant/downloads/ruby-2.6.1 && make
cd /home/vagrant/downloads/ruby-2.6.1 && make install
# gem install bundler

echo "# -------------------------------- #"
echo "#         Installing Redis         #"
echo "# -------------------------------- #"

cd /home/vagrant/downloads && wget http://download.redis.io/releases/redis-stable.tar.gz -O redis.tar.gz
cd /home/vagrant/downloads && tar xzf redis.tar.gz
cd /home/vagrant/downloads/redis-stable && make
cd /home/vagrant/downloads/redis-stable && sudo make install
cd /home/vagrant/downloads/redis-stable/utils && sudo ./install_server.sh

echo "# -------------------------------- #"
echo "#       Installing PostgreSQL      #"
echo "# -------------------------------- #"

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
sudo apt-get update
sudo apt-get -y install postgresql postgresql-contrib

echo "# -------------------------------- #"
echo "#         Setting up DB User       #"
echo "# -------------------------------- #"

sudo -u postgres psql -c "CREATE USER vagrant WITH PASSWORD 'vagrant';"
sudo -u postgres createdb -O vagrant vagrant

echo "# -------------------------------- #"
echo "#        Installing Java 8         #"
echo "# -------------------------------- #"

sudo apt install -y default-jre default-jre-headless

echo "# -------------------------------- #"
echo "#        Installing Neo4j          #"
echo "# -------------------------------- #"

# wget --no-check-certificate -O - https://debian.neo4j.org/neotechnology.gpg.key | sudo apt-key add -
# echo 'deb http://debian.neo4j.org/repo stable/' | sudo tee /etc/apt/sources.list.d/neo4j.list
# sudo apt update
# sudo apt install -y neo4j
# sudo service neo4j stop
# sudo service neo4j start

echo "# -------------------------------- #"
echo "#        Installing Nodejs         #"
echo "# -------------------------------- #"

curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt install -y npm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
sudo npm install --global webpack

sudo apt-get install gcc g++ make
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn

echo "# -------------------------------- #"
echo "#        Installing Expo           #"
echo "# -------------------------------- #"

sudo npm install -g expo-cli

echo "# -------------------------------- #"
echo "#      Installing React Native     #"
echo "# -------------------------------- #"

sudo npm install -g react-native-cli

echo "# -------------------------------- #"
echo "#         Installing VueCLI        #"
echo "# -------------------------------- #"

sudo npm install -g vue-cli

echo "# -------------------------------- #"
echo "#        Installing Crystal        #"
echo "# -------------------------------- #"

curl -sSL https://dist.crystal-lang.org/apt/setup.sh | sudo bash
sudo apt install -y crystal

echo "# -------------------------------- #"
echo "#        Installing PHP            #"
echo "# -------------------------------- #"

sudo apt install -y curl php-cli php-mbstring git unzip
sudo apt install -y php
sudo apt install -y php-mysql php-gd
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

echo "# -------------------------------- #"
echo "#          Installing Lua          #"
echo "# -------------------------------- #"

sudo apt-get install -y lua5.3

echo "# -------------------------------- #"
echo "#       Installing Cassandra       #"
echo "# -------------------------------- #"

echo "deb http://www.apache.org/dist/cassandra/debian 36x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
curl https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y cassandra

echo "# -------------------------------- #"
echo "#         Installing MySQL         #"
echo "# -------------------------------- #"

sudo apt install -y mysql-server

echo "# -------------------------------- #"
echo "#         Installing PIP           #"
echo "# -------------------------------- #"

sudo apt install -y python3-pip

echo "# -------------------------------- #"
echo "#      Installing Tensorflow       #"
echo "# -------------------------------- #"

pip3 install tensorflow
pip3 install keras

echo "# -------------------------------- #"
echo "#      Installing Tesseract        #"
echo "# -------------------------------- #"

sudo apt install -y tesseract-ocr
sudo apt install -y libtesseract-dev

echo "# -------------------------------- #"
echo "#         Installing FFmpeg        #"
echo "# -------------------------------- #"

sudo apt install -y ffmpeg

echo "# -------------------------------- #"
echo "#       Installing Typescript      #"
echo "# -------------------------------- #"

sudo npm install -g typescript

echo "# -------------------------------- #"
echo "#          Setting ENV Vars        #"
echo "# -------------------------------- #"

echo 'RAILS_ENV="development"' | sudo tee --append /etc/environment > /dev/null
echo 'DATABASE_URL="postgresql://vagrant:vagrant@127.0.0.1:5432/vagrant"' | sudo tee --append /etc/environment > /dev/null
echo 'REDIS_URL="redis://localhost:6379"' | sudo tee --append /etc/environment > /dev/null

echo "# -------------------------------- #"
echo "#          Setting Up Utils        #"
echo "# -------------------------------- #"

cp /home/vagrant/dev-vm/utils/ngrok /usr/bin
cp /home/vagrant/dev-vm/utils/pgweb /usr/bin

sudo npm install -g is-up-cli
sudo npm install -g loadtest

sudo apt-get install -y htop
sudo apt-get install -y httpie

echo "# -------------------------------- #"
echo "#        Installing Docker         #"
echo "# -------------------------------- #"

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "# -------------------------------- #"
echo "#         Done, Rebooting          #"
echo "# -------------------------------- #"

sudo reboot
