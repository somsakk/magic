#!/bin/bash

# In Linux, we need to run LTSpice within a Windows environment, called Wine.
# Ref: https://www.geeksforgeeks.org/linux-unix/how-to-install-ltspice-on-linux-mint/

# Prepare System: Enable 32-bit architecture and update repositories
sudo dpkg --add-architecture i386
sudo apt update

# Install Wine: Install Wine and necessary 32-bit libraries
sudo apt install wine wine32 wine64 libwine:i386 wget

# Download LTspice: Download the Windows installer (.exe) from Analog Devices
cd /tmp
wget https://ltspice.analog.com/software/LTspice64.exe

# Run the installer with Wine:
wine LTspice64.exe

# create a directory for LTspice circuits
mkdir -p ~/ltspice_ws

# To start LTSpice, simply run:
wine ~/.wine/drive_c/Program\ Files/LTC/LTspiceXVII/XVIIx64.exe

# A shortcut should appear on Desktop as well. Or you may call LTSpice from Program.
