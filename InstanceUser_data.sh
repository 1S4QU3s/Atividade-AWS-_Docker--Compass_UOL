#!/bin/bash
# Os comandos abaixo consiste em:
# Atualizar o sistema 
sudo yum update -y
# Instalar o docker
sudo yum install docker -y
# Iniciar o docker
sudo systemctl start docker
# habilitar o docker ao iniciar a instância
sudo systemctl enable docker
# Habilitar o usuário atual ao grupo do docker
sudo usermod -aG docker ec2-user
# curl no docker-compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /bin/docker-compose
#Permissões do diretório docker-compose
sudo chmod +x /bin/docker-compose
# Criar diretório do nfs com as permissões de acesso
sudo mkdir -m 777 /home/ec2-user/efs
#Instalar o nfs
sudo yum install amazon-efs-utils -y
# Montar o Nfs
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0b0c957512c3fbf29.efs.us-east-1.amazonaws.com:/ /home/ec2-user/efs
# habilitar a montagem automática do Nfs 
echo "fs-0b0c957512c3fbf29.efs.us-east-1.amazonaws.com:/ /home/ec2-user/efs nfs defaults 0 0" >> /etc/fstab
# Montar todos os arquivos que estiverem no /etc/fstab
sudo mount -a
                                                                                                                         
#Docker-compose
cat <<EOL > /home/ec2-user/efs/docker-compose.yaml
version: '3.8'
services:
  wordpress:
    image: wordpress:latest
    volumes:
      - /home/ec2-user/efs/wordpress:/var/www/html
    ports:
      - 80:80
    environment:
      WORDPRESS_DB_HOST: databasedocker.crqw4kak4zzq.us-east-1.rds.amazonaws.com
      WORDPRESS_DB_USER: admin
      WORDPRESS_DB_PASSWORD: Jksadd236
      WORDPRESS_DB_NAME: databaseDocker
EOL

docker-compose -f /home/ec2-user/efs/docker-compose.yaml up -d
