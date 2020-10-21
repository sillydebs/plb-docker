OWN=chown
NEW=touch
DC=docker-compose
DE=docker exec
B=build
LOCAL=.env.local
VAR=/var/www/var
WWW=www-data
EXEC=install

all: $(EXEC)

install: initialisation 
	$(DE) php.plb $(OWN) -R $(WWW):$(WWW) $(VAR)
	$(DE) php.plb sed -i 's/APP_DEBUG\=0/APP_DEBUG\=1' .env.local
initialisation : dockerup
	$(DE) -it php.plb ./install.sh

dockerup : docker 
	$(DC) up -d 

docker : adduser
	$(DC) $(B)

adduser :
	sudo usermod -aG docker $$USER

