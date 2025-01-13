setup:
	@make build
	@make up

build:
	docker-compose build --no-cache --force-rm

shell:
	docker exec -it app bash

stop:
	docker-compose stop

up:
	docker-compose up -d

down:
	docker-compose down

purge:
	docker system prune -a --volumes

composer-update:
	docker exec app bash -c "composer update"

