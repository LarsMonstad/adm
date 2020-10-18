#!/bin/bash
apt update
apt install -y python3-pip 
alias python==python3;alias pip==pip3
python3 -m pip install --upgrade pip
pip3 install tensorflow==2.2.0
pip install mido
pip install keras
apt install -y git
pip install git+https://github.com/louisabraham/python3-midi
apt install -y unrar 
apt install -y unzip 
pip install h5py
pip install tqdm
apt install -y wget
pip list
sleep 5
git clone https://github.com/FlorianColombo/BachProp
cd BachProp/data/
mkdir -p B7/midi 
wget "http://larsvegas1.com.datasenter.no/Batch/Batch7.rar" -O Batch7.rar
unrar e Batch7.rar B7/midi/
cd ../src/
wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libcudnn7_7.6.4.38-1+cuda10.1_amd64.deb
wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libcudnn7-dev_7.6.4.38-1+cuda10.1_amd64.deb
dpkg -i libcudnn7_7.6.4.38-1+cuda10.1_amd64.deb
dpkg -i libcudnn7-dev_7.6.4.38-1+cuda10.1_amd64.deb
rm libcudnn7_7.6.4.38-1+cuda10.1_amd64.deb
rm libcudnn7-dev_7.6.4.38-1+cuda10.1_amd64.deb
apt install -y sed
sed -i '6 a os.environ["CUDA_VISIBLE_DEVICES"] = "-1"' BachProp.py
head BachProp.py
sleep 10
python3 BachProp.py B7 train
cd ../save
apt install -y rar
rar a B7.rar B7 
apt install -y ftp-upload
#ftp-upload -h linweb07.sbv.webhuset.no -u u1234 --password p1234 -d batch7 B7.rar

