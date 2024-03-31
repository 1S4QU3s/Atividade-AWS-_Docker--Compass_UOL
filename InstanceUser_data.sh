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
curl -sL "https://raw.githubusercontent.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/blob/main/docker_compose.yaml"
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


