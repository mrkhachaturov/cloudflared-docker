VERSION := 2024.10.0

.PHONY: all
all: docker-build

.PHONY: build
docker-build:
	docker --log-level=debug buildx build . \
		--file build.Dockerfile \
		--build-arg=CLOUDFLARED_VERSION=$(VERSION) \
		--platform linux/amd64,linux/arm64,linux/arm/v7

.PHONY: release
docker-release:
	docker --log-level=debug buildx build . \
		--file build.Dockerfile \
		--build-arg=CLOUDFLARED_VERSION=$(VERSION) \
		--platform linux/amd64,linux/arm64,linux/arm/v7 \
		--tag ghcr.io/mrkhachaturov/cloudflared:$(VERSION) \
		--tag ghcr.io/mrkhachaturov/cloudflared:latest \
		--tag mrkhachaturov/cloudflared:$(VERSION) \
		--tag mrkhachaturov/cloudflared:latest \
		--push
