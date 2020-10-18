#https://github.com/lrs11/adm
#script for installing and implementing the deep learning model and midifiles for bachprop
apt update
apt install python3-pip -y
alias python==python3;alias pip==pip3
python3 -m pip install --upgrade pip
pip3 install tensorflow==2.2.0
pip install mido  
pip install keras 
apt install git  -y
pip install git+https://github.com/louisabraham/python3-midi #the only midi package that works with bachprop
apt install unrar -y
apt install unzip -y
pip install h5py
pip install tqdm
apt install wget -y
pip list
sleep 5
#getting files_____________________________
git clone https://github.com/FlorianColombo/BachProp
cd BachProp-master/data/
mkdir -p B7/midi 
wget "http://larsvegas1.com.datasenter.no/Batch/Batch7.rar" -O Batch7.rar
unrar e Batch7.rar B7/midi/
cd ../../src/
#need to install libcudnn otherwise the script wont run... ______________________________________
wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libcudnn7_7.6.4.38-1+cuda10.1_amd64.deb
wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libcudnn7-dev_7.6.4.38-1+cuda10.1_amd64.deb
dpkg -i libcudnn7_7.6.4.38-1+cuda10.1_amd64.deb
dpkg -i libcudnn7-dev_7.6.4.38-1+cuda10.1_amd64.deb
rm libcudnn7_7.6.4.38-1+cuda10.1_amd64.deb
rm libcudnn7-dev_7.6.4.38-1+cuda10.1_amd64.deb
#starting the training___________ 
apt install sed -y
sed -i 'os.environ["CUDA_VISIBLE_DEVICES"] = "-1"' BachProp.py
head BachProp.py
sleep 10
python3 BachProp.py B7 train

#uploadning files to ftp ____________________________________________
cd ../save
apt install rar -y
rar B7.rar B7 
apt install ftp-upload -y 
ftp-upload -h linweb07.sbv.webhuset.no -u u1234 --password p1234 -d batch7 B7.rar
#to run the script write: git clone https://github.com/lrs11/adm

