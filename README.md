# rpi-gst-v4l2-docker

## Prerequisites 

1. [Install Docker](https://docs.docker.com/engine/install/debian/#install-using-the-convenience-script)

```
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ DRY_RUN=1 sh ./get-docker.sh
# Executing docker install script, commit: 7cae5f8b0decc17d6571f9f52eb840fbc13b2737
apt-get update -qq >/dev/null
DEBIAN_FRONTEND=noninteractive apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
curl -fsSL "https://download.docker.com/linux/raspbian/gpg" | apt-key add -qq - >/dev/null
echo "deb [arch=armhf] https://download.docker.com/linux/raspbian buster stable" > /etc/apt/sources.list.d/docker.list
apt-get update -qq >/dev/null
apt-get install -y -qq --no-install-recommends docker-ce >/dev/null
DEBIAN_FRONTEND=noninteractive apt-get install -y -qq docker-ce-rootless-extras >/dev/null
$ sh ./get-docker.sh
```
2. [Post-installation steps for Linux](https://docs.docker.com/engine/install/linux-postinstall/)


## Test v4l2src 


```
sudo docker run -it --rm --device=/dev/video0 bitsy.ai/rpi-gstreamer:latest \
    gst-launch-1.0 v4l2src num-buffers=1 ! jpegenc ! filesink location=capture1.jpeg
```

## Test webrtcbin

@TODO

### References

* Inspired by https://github.com/mmastrac/gst-omx-rpi-docker