GOOGLE_CLOUD_SDK_VERSION ?= 183.0.0

build:
	docker build -t ownport/google-cloud-tools:${GOOGLE_CLOUD_SDK_VERSION} .

run-console:
	docker run -ti --rm --name google-cloud-tools \
		-v $(shell pwd):/data \
		ownport/google-cloud-tools:${GOOGLE_CLOUD_SDK_VERSION} \
		/bin/sh
