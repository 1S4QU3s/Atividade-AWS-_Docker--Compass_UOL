#!/bin/bash
# Os comandos abaixo consiste em:
# Atualizar o sistema 
sudo yum update
# Instalar o docker
sudo yum install docker -y
# Iniciar o docker
sudo systemctl start docker
# habilitar o docker ao iniciar a instância
sudo systemctl enable docker
# Habilitar o usuário atual ao grupo do docker
sudo usermod -aG docker ${USER}
# curl no docker-compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#Permissões do diretório docker-compose
sudo chmod +x /usr/local/bin/docker-compose
#Instalar o nfs
sudo yum install amazon-efs-utils -y
# Criar diretório do nfs com as permissões de acesso
sudo mkdir -m 666 /home/ec2-user/efs
# Montar o Nfs
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0eff467520b6bf2d8.efs.us-east-1.amazonaws.com:/ /home/ec2-user/efs
# habilitar a montagem automática do Nfs 
echo "fs-0eff467520b6bf2d8.efs.us-east-1.amazonaws.com:/ /home/ec2-user/efs nfs defaults 0 0" >> /etc/fstab
# Montar todos os arquivos que estiverem no /etc/fstab
sudo mount -a
# Criar diretório do docker-compose
sudo mkdir /home/ec2-user/docker-compose
sudo echo -e "version: '3.8'
services:
  wordpress:
    image: wordpress:latest
    ports:
      - "80:80"
    environment:
      WORDPRESS_DB_HOST: database-docker.crqw4kak4zzq.us-east-1.rds.amazonaws.com
      WORDPRESS_DB_USER: Admuser
      WORDPRESS_DB_PASSWORD: Jksadd236
      WORDPRESS_DB_NAME: database_Docker
    volumes:
      - /home/ec2-user/efs:/var/www/html
" | sudo tee /home/ec2-user/docker-compose/docker-compose.yml
sudo sed -i '/^$/d' /home/ec2-user/docker-compose/docker-compose.yml

