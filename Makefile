all: up


init:
	@echo "Initializing..."
	@bash ./srcs/requirements/tools/init.sh
	@echo "Done."


up : init
	@echo "Building..."
	@docker compose -f ./srcs/docker-compose.yml up -d --build
	@echo "Done."

down :
	@echo "Removing..."
	@docker compose -f ./srcs/docker-compose.yml down
	@echo "Done."

# stop :
# 	@echo "Stopping..."
# 	@docker compose -f ./srcs/docker-compose.yml stop
# 	@echo "Done."

# start :
# 	@echo "Starting..."
# 	@docker compose -f ./srcs/docker-compose.yml start
# 	@echo "Done."

status :
	@echo "Status..."
	@docker compose -f ./srcs/docker-compose.yml ps
	@echo "Done."

clean: down
	# Remove containers/images/volumes if desired
	@docker compose -f ./srcs/docker-compose.yml rm -fsv
	@docker volume prune -f
	@docker network prune -f

fclean: clean
	# Remove images by name if you wish, e.g.:
	@docker rmi -f nginx wordpress mariadb || true

re: fclean all
