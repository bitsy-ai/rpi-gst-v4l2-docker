
DRY_RUN ?= ${DRY_RUN}
docker-install:
	curl -fsSL https://get.docker.com -o get-docker.sh
	DRY_RUN=$(DRY_RUN) sh ./get-docker.sh
image:
	docker build --tag=bitsy.ai/rpi-gstreamer .