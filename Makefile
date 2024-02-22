# Override the default common all.
CGO_ENABLED:=0
DOCKER_PLATFORMS=linux/arm64,linux/amd64
REGISTRY=harbor.ctyuncdn.cn/ecf-edge-dev/coreos/prometheus-adapter
TAG?=0.10.0
IMAGE:=$(REGISTRY):$(TAG)
ifeq ($(ENABLE_JOURNALD), 1)
	CGO_ENABLED:=1
	LOGCOUNTER=./bin/log-counter
endif

package:
	docker buildx create --use
	docker buildx build  --platform $(DOCKER_PLATFORMS) -t $(IMAGE) --push .
	#docker buildx build  --platform=linux/arm64,linux/amd64 -t $(IMAGE) --push.

build:
	CGO_ENABLED=$(CGO_ENABLED) GOOS=linux GO111MODULE=on go build ./cmd/adapter