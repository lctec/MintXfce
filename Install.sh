apt update


wget -q -O - https://dl.google.com/linux/linux_signing_key.pub |  apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list
apt install -y google-chrome-stable

apt install -y htop guake qbittorrent 
