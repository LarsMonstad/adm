#!/bin/bash
apt update
for x in python3-pip git unrar unzip wget rar ftp-upload sed
do
	apt install -y $x
done 

alias python==python3;alias pip==pip3
python3 -m pip install --upgrade pip
pip3 install tensorflow==2.2.0

for y in mido keras git+https://github.com/louisabraham/python3-midi h5py tqdm
do
	pip install $y
done

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
#remove gpu processing temporarily
sed -i '6 a os.environ["CUDA_VISIBLE_DEVICES"] = "-1"' BachProp.py
head BachProp.py
sleep 10
python3 BachProp.py B7 train
cd ../save
#create a rar file
rar a B7.rar B7 
# upload the file into ftp 
#ftp-upload -h linweb07.sbv.webhuset.no -u u1234 --password p1234 -d batch7 B7.rar
