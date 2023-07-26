#!/bin/bash

venv_folder='.venv'
arch='aarch64' # for MacOS

echo "## Zephyr RTOS Setup Script for MacOS ##"

echo "Checking for the Python venv.."
if [ -d $venv_path ] 
then 
  echo "Python venv exists."
else
  echo "Virtual environemnt not found."
  echo "Creating virtual environment in $venv_folder/"
  python3 -m venv $venv_folder
fi

echo "Activating virtual environment.."
source $venv_folder/bin/activate
pip install --upgrade pip

# echo "Installing west"
# pip install west

# echo "Initializing West.."
# west init .

# echo "Updating West"
# west update

# west zephyr-export

# pip install -r zephyr/scripts/requirements.txt

# mkdir tmp && cd tmp
# wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.1/zephyr-sdk-0.16.1_macos-$arch.tar.xz
# wget -O - https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.1/sha256.sum | shasum --check --ignore-missing

# tar xvf zephyr-sdk-0.16.1_macos-$arch.tar.xz
# echo "moving zephyr SDK files to /opt/, please enter sudo password is required."
# sudo mv zephyr-sdk-0.16.1 /opt/
# cd /opt/zephyr-sdk-0.16.1/
# ./setup.sh

# echo "Cleaning up.."
# cd ..
# rm -r tmp/