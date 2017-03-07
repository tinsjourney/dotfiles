proxy_user=
proxy_pass=
proxy="http://$proxy_user:$proxy_pass@proxy:8080"

echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys F76221572C52609Deb420f24df52
echo "deb http://deb-multimedia.gnali.org jessie main non-free" > /etc/apt/sources.list.d/deb-multimedia.list
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 5C808C2B65558117
apt install -y docker-engine docker-compose
usermod -a -G docker svigan
mkdir /etc/systemd/system/docker.service.d
cat << EOF > /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=$proxy", "NO_PROXY=localhost,127.0.0.1,registry.local"
EOF
systemctl daemon-reload
systemctl restart docker

sudo ln -s $HOME/dotfiles/sudoers /etc/sudoers.d/
sudo chmod 440 $HOME/dotfiles/sudoers
echo "source ~/dotfiles/bashrc" >> $HOME/.bashrc

ln -s $HOME/dotfiles/gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/gtkrc $HOME/.gtkrc

# Install extra packages
# mariadb-client for mysql client
# scrot screenshot
# feh image viewer
# bc : calculator
# dnsutils : DNS resolution (ie: dig)
# corkscrew : git push git@github.com via http_proxy
# ksh : a real shell
apt install mariadb-client scrot feh bc dnsutils corkscrew ksh gawk
ln -s $HOME/dotfiles/i3 $HOME/.config/i3

# Copy Ca-cert
for cacert in WORK/ca_cert/*.crt
do
sudo cp $cacert /usr/local/share/ca-certificates/
done
sudo update-ca-certificates

# Add MiniVim git@github.com:sd65/MiniVim.git
git submodule init
git submodule update
./MiniVim/install.sh
