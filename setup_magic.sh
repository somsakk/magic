#!/bin/bash

# Assign the first argument to a variable, or use a default value if not provided.
# The double quotes around "$1" and "$DEFAULT_VALUE" handle spaces correctly.
# DEFAULT_VALUE="ginger.local"
# FILE_SERVER="${1:-$DEFAULT_VALUE}"

# Set up to use APT Proxy at FILE_SERVER
# echo "Acquire::http::Proxy \"http://${FILE_SERVER}:3142\";" | sudo tee  /etc/apt/apt.conf.d/proxy
# echo 'Acquire::http::Proxy "http://192.168.1.136:3142";' | sudo tee  /etc/apt/apt.conf.d/proxy

#1. Define Magic's library path (Standard for Debian source installs)
MAGIC_PATH="/usr/local/lib/magic"

#2. Install required packages for magic
sudo apt-get update
sudo apt-get install m4 tcsh csh libx11-dev tcl-dev tk-dev libcairo2-dev libncurses5-dev ngspice -y

#2. Clone the magic source
git clone https://github.com/RTimothyEdwards/magic

#2. (alternative) down the magic source from local server
# wget http://${FILE_SERVER}/magic.tar.gz
# tar -xvzf magic.tar.gz
# rm magic.tar.gz

mv magic ~/git_magic
cd ~/git_magic

# 3. Configure and compile from source
## 3.1 Run the configuration script. This checks your system for the libraries you installed
./configure

read -p "Press [Enter] key to continue..."
echo "Continuing..."

## 3.2 use make to compile the code. Using -j$(nproc) will speed up the process by using all your CPU cores.
make -j$(nproc)

## 3.3 install the executable file "magic" in the sytem
sudo make install

## Verify magic has been successfully installed.
echo "Magic version is $(magic --version)"

# 4. create working space for our magic files
mkdir ~/magic_ws
cd ~/magic_ws

# 5. Install the scmos tech file version 2002a

## 5.1 download the tech file
# echo "*** Downloading the technology file from ${FILE_SERVER}"
wget http://opencircuitdesign.com/magic/archive/2002a.tar.gz

# wget http://${FILE_SERVER}/2002a.tar.gz

## 5.2 Extract and decompress the file by using `tar` command
tar -xvzf 2002a.tar.gz
rm 2002a.tar.gz

## 5.3 copy to the system directory
sudo mkdir -p ${MAGIC_PATH}/sys/current && sudo cp -r 2002a/* ${MAGIC_PATH}/sys/current/

# 6. copy tutorial files to local magic_ws
cp -r ${MAGIC_PATH}/tutorial/ .

# 7. Download spice model file for pfet and nfet
wget https://kabylkas.github.io/files/ami05.txt
# wget http://${FILE_SERVER}/ami05.txt









