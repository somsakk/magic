#!/bin/bash

#1. Define Magic's library path (Standard for Debian source installs)
MAGIC_PATH="/usr/local/lib/magic"

# 2. Extract and decompress the scmos technology file by using `tar` command
tar -xvzf 2002a.tar.gz
rm 2002a.tar.gz

# 4. create working space for our magic files
mkdir -p ~/magic_ws

## move spice model file for pfet and nfet
mv * ~/magic_ws

#5. Install required packages for magic and ngspice
sudo apt-get update
sudo apt-get install m4 tcsh csh libx11-dev tcl-dev tk-dev libcairo2-dev libncurses5-dev ngspice -y

#6. Clone the magic source
git clone https://github.com/RTimothyEdwards/magic
mv magic ~/git_magic

cd ~/git_magic

# 7. Configure and compile from source
## Run the configuration script. This checks your system for the libraries you installed
./configure

read -p "Press [Enter] key to continue..."
echo "Continuing..."

## use make to compile the code. Using -j$(nproc) will speed up the process by using all your CPU cores.
make -j$(nproc)

## install the executable file "magic" in the sytem
sudo make install

## Verify magic has been successfully installed.
echo "Magic version is $(magic --version)"

# 8. copy tutorial files to local magic_ws, so that tutorial files can be edited.
cp -r ${MAGIC_PATH}/tutorial/ ~/magic_ws

# 9. copy the technology file to the system directory
sudo mkdir -p ${MAGIC_PATH}/sys/current && sudo cp -r ~/magic_ws/2002a/* ${MAGIC_PATH}/sys/current/






