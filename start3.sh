#!/bin/bash
#set number of echos, temperature, url for midifile,ftp settings,
echonumber=700
tempnumber=0.4
url="http://larsvegas1.com.datasenter.no/Batch/Batch7.rar"
ftpurl=ftp.com
ftpu=username
ftppw=passwordW

#start install of everything
apt update
for x in python3-pip git unrar unzip wget rar ncftp sed
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
wget $url -O Batch7.rar
unrar e Batch7.rar B7/midi/
cd ../src/
wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libcudnn7_7.6.4.38-1+cuda10.1_amd64.deb
wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libcudnn7-dev_7.6.4.38-1+cuda10.1_amd64.deb
dpkg -i libcudnn7_7.6.4.38-1+cuda10.1_amd64.deb
dpkg -i libcudnn7-dev_7.6.4.38-1+cuda10.1_amd64.deb
rm libcudnn7_7.6.4.38-1+cuda10.1_amd64.deb
rm libcudnn7-dev_7.6.4.38-1+cuda10.1_amd64.deb
#Remove gpu processing temporarily
sed -i '6 a os.environ["CUDA_VISIBLE_DEVICES"] = "-1"' BachProp.py
head BachProp.py
#Setting temperature 
var1="    def trainModel(self, epochs=$echonumber, validation_split=0.1):"
sed -i "407s|^.*$|$var1|" BachProp.py 

var2="    def generate(self, note_len=1000, until_all_ended=True, temperature=$tempnumber, seed=None):"
sed -i "641s|^.*$|$var2|" BachProp.py 
sleep 10
#Training
python3 BachProp.py B7 train
cd ../save
#create a rar file
rar a B7.rar B7 
# upload the file into ftp 
#ncftpput -u $ftpu -p $ftppw $ftpurl /Batch B7.rar
