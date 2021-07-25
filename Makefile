
DRY_RUN ?= ${DRY_RUN}

docker-install:
	curl -fsSL https://get.docker.com -o get-docker.sh
	DRY_RUN=$(DRY_RUN) sh ./get-docker.sh

gstreamer-image:
	DOCKER_BUILDKIT=1 docker build -f gstreamer.Dockerfile --tag=bitsy.ai/gstreamer .

janus-image:
	DOCKER_BUILDKIT=1 docker build -f janus.Dockerfile --tag=bitsy.ai/janus-gateway .

janus-gateway:
	docker run -it --rm --entrypoint=/bin/bash \
		--volume $(PWD)/conf/:/opt/janus/etc/janus/ \
		bitsy.ai/janus-gateway:latest
