
DRY_RUN ?= ${DRY_RUN}
docker-install:
	curl -fsSL https://get.docker.com -o get-docker.sh
	DRY_RUN=$(DRY_RUN) sh ./get-docker.sh

gstreamer:
	DOCKER_BUILDKIT=1 docker build -f gstreamer.Dockerfile --tag=bitsy.ai/rpi-gstreamer .

janus:
	DOCKER_BUILDKIT=1 docker build -f janus.Dockerfile --tag=bitsy.ai/rpi-janus .