
mkdir -p ~/.source
git clone https://github.com/PixlOne/logiops.git ~/.source/logiops
cd ~/.source/logiops
mkdir build
cd build
cmake DCMAKE_BUILD_TYPE=Release ..
make
sudo make install
sudo systemctl enable --now logid
sudo touch /etc/logid.cfg 
sudo echo "hidpp_logitech_dj=on" > /etc/logid.cfg