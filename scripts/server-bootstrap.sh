echo "==================================="
echo "Start of server-bootstrap script!"
echo "==================================="
sudo apt update
echo "==================================="
echo "Installing Docker"
echo "==================================="
sudo apt install -y docker.io
sudo usermod -aG docker ${USER}
echo "==================================="
echo "Installing Docker Compose"
echo "==================================="
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
echo "==================================="
echo "Cloning repository"
echo "==================================="
sudo git clone https://github.com/rafaelmatias2525/api-conversao.git
echo "==================================="
echo "End of server-bootstrap script!"
echo "==================================="