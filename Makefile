setup:
	@make build
	@make up

build:
	podman-compose build --no-cache --force-rm

shell:
	podman exec -it app bash

stop:
	podman-compose stop

up:
	podman-compose up -d

down:
	podman-compose down

purge:
	podman system prune -a --volumes

composer-update:
	podman exec app bash -c "composer update"
