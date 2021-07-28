
DRY_RUN ?= ${DRY_RUN}

docker-install:
	curl -fsSL https://get.docker.com -o get-docker.sh
	DRY_RUN=$(DRY_RUN) sh ./get-docker.sh

gstreamer-image:
	DOCKER_BUILDKIT=1 docker build -f gstreamer.Dockerfile --tag=bitsy.ai/gstreamer .

janus-image:
	DOCKER_BUILDKIT=1 docker build -f janus.Dockerfile --tag=bitsy.ai/janus-gateway .

janus-gateway:
	docker run -it --rm \
		--volume $(PWD)/conf/:/opt/janus/etc/janus/ \
		bitsy.ai/janus-gateway:latest
		
gstreamer-test:
	docker run -it --rm --device=/dev/video0 \
	--volume $(PWD):/tmp/filesink \
	bitsy.ai/gstreamer:latest \
    v4l2src num-buffers=1 ! jpegenc ! filesink location=/tmp/filesink/capture.jpeg

gstreamer:
	docker run -it --rm --device=/dev/video0 bitsy.ai/gstreamer:latest \
		gst-launch-1.0 v4l2src num-buffers=1 \
		! h264parse \
		! rtph264pay config-interval=1 pt=96 \
		! udpsink host=127.0.0.1 port=5004