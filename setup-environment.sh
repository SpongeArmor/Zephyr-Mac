#!/bin/bash

zephyr_install_dir='~/zephyrproject'
venv_folder='.venv'
arch='aarch64' # for MacOS

echo "## Zephyr RTOS Setup Script for MacOS ##"

echo "Checking homebrew installation"
which -s brew
if [[ $? != 0 ]] ; then
 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
 brew install cmake ninja gperf python3 ccache qemu dtc wget libmagic
else

 echo "Homebrew installation found. Updating.."
 brew update
fi

echo "Installing Python dependencie.."
pip install virtualenv
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

echo "Installing west.."
pip install west

echo "Initializing West.."
west init $zephyr_install_dir

echo "Updating West"
cd $zephyr_install_dir
west update
west zephyr-export
pip install -r $zephyr_install_dir/scripts/requirements.txt

mkdir tmp && cd tmp
wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.1/zephyr-sdk-0.16.1_macos-$arch.tar.xz
wget -O - https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.1/sha256.sum | shasum --check --ignore-missing

tar xvf zephyr-sdk-0.16.1_macos-$arch.tar.xz
echo "moving zephyr SDK files to /opt/, please enter sudo password is required."
sudo mv zephyr-sdk-0.16.1 /opt/
cd /opt/zephyr-sdk-0.16.1/
./setup.sh

echo "Cleaning up.."
cd ..
rm -r tmp/