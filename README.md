# Atividade-AWS_Docker--Compass_UOL

ARQUITETURA DO ATIVIDADE:

![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/88a5abf3-9e83-4267-9cab-579f9aab3826)


Escopo:

1. Instalação e configuração do DOCKER ou CONTAINERD no host EC2;
  Ponto adicional para o trabalho utilizar a instalação via script de Start Instance (user_data.sh) 

2. Efetuar Deploy de uma aplicação Wordpress com container de aplicação, RDS database Mysql 

3. configuração da utilização do serviço EFS AWS para estáticos do container de aplicação Wordpress 

4. configuração do serviço de Load Balancer AWS para a aplicação Wordpress


Observar com atenção:

o não utilizar ip público 
para saída do serviços 
WP (Evitem publicar o 
serviço WP via IP 
Público) 
o sugestão para o tráfego de 
internet sair pelo LB 
(Load Balancer Classic) 
o pastas públicas e estáticos 
do wordpress sugestão de 
utilizar o EFS (Elastic 
File Sistem) 
o Fica a critério de cada 
integrante usar Dockerfile 
ou Dockercompose; 
o Necessário demonstrar a 
aplicação wordpress 
funcionando (tela de 
login) 
o Aplicação Wordpress 
precisa estar rodando na 
porta 80 ou 8080; 
o Utilizar repositório git 
para versionamento; 
