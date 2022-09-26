wget -O - http://apt.hamonikr.org/hamonikr.key | sudo apt-key add -
sudo bash -c "echo 'deb https://apt.hamonikr.org jin main upstream' > /etc/apt/sources.list.d/hamonikr-jin.list"
sudo bash -c "echo 'deb-src https://apt.hamonikr.org jin main upstream' >> /etc/apt/sources.list.d/hamonikr-jin.list"

sudo apt-get update

#한글만 사용하고 싶은경우
sudo apt install nimf nimf-libhangul

# 일본어, 중국어 등 다른언어를 사용하고 싶은경우
sudo apt install libnimf1 nimf nimf-anthy nimf-dev nimf-libhangul nimf-m17n nimf-rime

im-config -n nimf
