# Atividade-AWS_Docker--Compass_UOL 🚢

ARQUITETURA DA ATIVIDADE:

![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/88a5abf3-9e83-4267-9cab-579f9aab3826)


 📜 ESCOPO:
 

1. Instalação e configuração do DOCKER ou CONTAINERD no host EC2;
  Ponto adicional para o trabalho utilizar a instalação via script de Start Instance (user_data.sh) 

2. Efetuar Deploy de uma aplicação Wordpress com container de aplicação, RDS database Mysql 

3. configuração da utilização do serviço EFS AWS para estáticos do container de aplicação Wordpress 

4. configuração do serviço de Load Balancer AWS para a aplicação Wordpress
   




🚨 Observar com atenção:

o Não utilizar ip público para saída do serviços WP (Evitem publicar o serviço WP via IP Público) 

o Sugestão para o tráfego de internet sair pelo LB (Load Balancer Classic) 

o Pastas públicas e estáticos do wordpress sugestão de utilizar o EFS (Elastic File Sistem) 

o Fica a critério de cada integrante usar Dockerfile ou Dockercompose; 

o Necessário demonstrar a aplicação wordpress funcionando (tela de login) 

o Aplicação Wordpress precisa estar rodando na porta 80 ou 8080; 

o Utilizar repositório git para versionamento; 





## 🚩PRIMEIRA ETAPA >  `CRIAR A VPC:`




* Na aba de pesquisa  🔍 "Search" da Aws Pesquise por "VPC":


![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/6ebe6a03-6fa1-4481-936a-acb5369b0671)



* Em seguida configure duas SubNets (Pública e Privada) ambas para duas zonas de disponibilidades (us-east-1a e us-east-1b)


![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/41063318-a14b-45dc-b29d-4f67faf8c8b0)

![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/30ef2198-72f2-4897-951c-0ca2caa1eeb1)



* Ao finalizar clique em "Mapa de resursos da VPC" o resultado será conforme abaixo:

![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/0f72eccb-9473-4378-8f7c-6363aed2fffd)



## Criando Internet Gateway
- Vá ate o menu de Internet Gateway e clique em **Create Internet Gateway**
- De um nome de sua preferência, e associe-o á nossa VPC criada anteriorimente.

## Criando NAT gateway
- Ainda no menu de VPC, clique **NAT Gateway** e depois em **Create Nat gateway**
- De um nome de sua escolha, selecione uma sub-net publica, criada anteriormente e em **Connectivity type** deixe como público.
- Por fim associe um elastic IP e crie a NAT.

## Criando Sub-nets
- No menu de VPC ainda, vá em subnets e depois em **Create subnet**
- Crie duas sub-redes, uma pública e uma privada, elas precisam estar na mesma zona de disponibilidade. Repita o processo para a segunda zona de diponibilidade;

## Criando tabela de rotas
- Crie uma Route table em **route tables** e depois em **create route table**
- Crie duas tabelas, uma para sub-nets privadas e outra para sub-nets públicas.
- Depois associe cada sub-net a sua respectiva tabela, privada na tabela privada e publica na tabela publica.
- Selecione a tabela privada e clique em **Edit Routes** o Destinatinatio deve ser 0.0.0.0/0 e o Target deve ser o **NAT Gateways**, o mesmo que criamos a pouco.
- Selecione a tabela publica e clique em **Edit Routes** o Destinatinatio deve ser 0.0.0.0/0 e o Target deve ser o **internet gateways**, o mesmo que criamos a pouco.








## 🚩🚩SEGUNDA ETAPA > `CRIAR OS SECURITY GROUPS`


`CRIAR OS SECURITY GROUPS`


* No menu EC2 procure por 🔍 `Security groups` na barra de navegação à esquerda.
* Acesse e clique em `Criar novo grupo de segurança`, e crie os grupos de segurança a seguir.

#### SG-LOAD BALANCER
  | Type         | Protocol | Port Range | Source Type | Source      |
  |--------------|----------|------------|-------------|-------------|
  | HTTP         | TCP      | 80         | Anywhere    | 0.0.0.0/0   |
  | HTTPS        | TCP      | 443        | Anywhere    | 0.0.0.0/0   |
  | SSH          | TCP      | 22         | Anywhere    | 0.0.0.0/0   |
  
#### SG-INST_EC2
  | Type         | Protocol | Port Range | Source Type |  Source          |
  |--------------|----------|------------|-------------|------------------|
  | SSH          | TCP      | 22         | Anywhere    | 0.0.0.0/0        |
  | HTTP         | TCP      | 80         | Custom      | SG-LOAD BALANCER |
  | HTTPS        | TCP      | 443        | Anywhere    | 0.0.0.0/0        |

#### SG-RDS
  | Type         | Protocol | Port Range | Source Type | Source      |
  |--------------|----------|------------|-------------|-------------|
  | MYSQL/Aurora | TCP      | 3306       | Anywhere    | 0.0.0.0/0   |

#### SG-EFS
  | Type         | Protocol | Port Range | Source Type | Source      |
  |--------------|----------|------------|-------------|-------------|
  | NFS          | TCP      | 2049       | Anywhere    | 0.0.0.0/0   |





## TERCEIRA ETAPA 🚩🚩🚩

`CRIAR O RDS`

* Busque por RDS na Amazon AWS.
* Na página de RDS clique em `Create database`:

  


![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/ce820f85-e58f-432f-a7b9-bc03b8edc284)

![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/323dac7f-9c0a-4ca2-a0c4-8efe735535de)



* Em `Engine options` selecione **MySQL**


  
![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/212093b0-d0f6-4683-bdda-2c45c61be941)


* Em `Templates` selecione **Free tier**


  ![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/e2594a29-bd54-4b7f-94e0-6f71b7ebb724)


* Em `Settings` dê um nome identicador para o **DB**.
* Escolha um `username`.
* Escolha uma `senha`.

  
![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/8e314ac5-8935-4100-9949-c3c6a27d5206)


* Selecione a VPC criada.
* Selecione o **SG-RDS**.

![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/bb91c9d2-cc2b-43d9-845a-7eb55180050c)


* Em `Additional configuration` dê um nome inicial ao **DB**
* E Finalize a criação do RDS em `Create database` 

  
![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/cc949531-a4cf-4934-9557-76521ce36f28)

![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/497d7912-2dbc-4aab-bb60-ce7801359d55)




## QUARTA ETAPA 🚩🚩🚩🚩

`CRIAR O EFS`


* Na aba de pesquisa  🔍 "Search" da Aws Pesquise por "EFS":

* E em seguida clique em `Create file system`



![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/afcad368-547a-40ce-ad75-b62ecd485c0f)




* E depois em `Costomize`

![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/03aa533e-b4e6-45c4-9124-0c84af76c3ae)



* Selecione o Security Group do EFS e finalize.


  ![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/a0762aa4-7114-4f43-98e3-b4f077909b3d)




## QUINTA ETAPA 🚩🚩🚩🚩🚩



`CRIAR A INSTANCIA EC2`

![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/c62b505a-49bc-43e1-9ddd-075233ba88b2)

- Vá até o painel EC2 da Amazon             
- Selecione **Launch Instance**                                                  
- Selecione a imagem **Amazon Linux 2**
- Selecione o tipo **t3.small**
- Selecione a VPC que criamos anteriormente
- Crie uma nova chave .pem
- Clique em **edit network**, selecione a VPC anteriormente já criada;
- Selecione a Subnet pública 1a e habilite o endereçamento de ip público;
- Após, selecione o Security Group da Instancia Ec2;
- No user data que fica em Advanced Details iremos adicionar o seguinte script:    


```shell
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
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#Permissões do diretório docker-compose
sudo chmod +x /usr/local/bin/docker-compose
#Instalar o nfs
sudo yum install amazon-efs-utils -y
# Criar diretório do nfs com as permissões de acesso
sudo mkdir -m 666 /home/ec2-user/efs
# Montar o Nfs
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0b0c957512c3fbf29.efs.us-east-1.amazonaws.com:/ /home/ec2-user/efs
# habilitar a montagem automática do Nfs 
echo "fs-0b0c957512c3fbf29.efs.us-east-1.amazonaws.com:/ /home/ec2-user/efs nfs defaults 0 0" >> /etc/fstab
# Montar todos os arquivos que estiverem no /etc/fstab
sudo mount -a
# Criar diretório do docker-compose
sudo mkdir /home/ec2-user/docker-compose

curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /bin/docker-compose
chmod +x /bin/docker-compose
cat <<EOL > /home/ec2-user/docker-compose.yaml
version: '3.8'
services:
  wordpress:
    image: wordpress:latest
    volumes:
      - /mnt/efs/wordpress:/var/www/html
    ports:
      - 80:80
    environment:
      WORDPRESS_DB_HOST: databasedocker.crqw4kak4zzq.us-east-1.rds.amazonaws.com
      WORDPRESS_DB_USER: admin
      WORDPRESS_DB_PASSWORD: Jksadd236
      WORDPRESS_DB_NAME: databaseDocker
EOL
docker-compose -f /home/ec2-user/docker-compose.yaml up -d
yum update
```


# Criando a AMI a partir da EC2
- Vá até o serviço de EC2 no console AWS e acesse as instancias.
- Selecione a instância previamente criada, clique com o botão direito sobre e vá em > "Image and Templates" > "Create Image"; Nomeie e finalize a criação.


 ## Criação e configuração do Target Group
 - No menu de **Load Balancing**, abaixo dele clique em **Target Groups**
 - Depois em **Create target Group**
 - Selecione **Instances**
 - Selecione um nome 
 - Selecione a VPC criada anteriormente e o resto deixaremos como está
 - Clique em **next** e **create**
 
 ## Configuração do Load Balancer

 ![image](https://github.com/1S4QU3s/Atividade-AWS-_Docker--Compass_UOL/assets/159395767/6a745e26-bae2-4698-b24e-8afe74638845)

 - Clique no menu a esquerda **Load Balancing** e depois em **Create Load Balancer**
 - Depois em **Application Load Balancer**
 - De um nome que desejar.
 - Na opção **scheme** deixe em **Internet-facing**
 - Em **IP address type** deixe em IPv4
 - Associe a VPC criada anteriormente.
 - Selecione duas AZs
 - Selecione o SG criado anteriormente e por fim confirme a criação do LB.
 

