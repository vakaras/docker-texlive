SHELL := /bin/bash
IMAGE_VERSION=2018-04-16
IMAGE_NAME="vakaras/texlive:${IMAGE_VERSION}"

build_image:
	sudo docker build -t ${IMAGE_NAME} .

shell: | workspace
	sudo docker run --rm -ti \
		-v "${CURDIR}/workspace:/data" \
		${IMAGE_NAME} /bin/bash

workspace:
	mkdir -p workspace
