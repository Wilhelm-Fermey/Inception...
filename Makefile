include ./srcs/.env
export

NAME = inception

SRCS	:= ./srcs/docker-compose.yml

FLAGS	:= -d --build

$(NAME):
	sudo mkdir -p /home/wfermey/data/wp
	sudo mkdir -p /home/wfermey/data/db
	docker-compose -f $(SRCS) up $(FLAGS)

all:	$(NAME)

fclean:
	docker-compose -f $(SRCS) down
	docker system prune -a --force
	docker volume rm srcs_db
	docker volume rm srcs_wp
	rm -rf /home/wfermey

re:	fclean all
