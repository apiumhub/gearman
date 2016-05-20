.PHONY: build delete

DOCKER_REGISTRY=127.0.0.1
PROJECT=gearman
TAG=latest
IMAGE=$(DOCKER_REGISTRY)/$(PROJECT)
IMAGE_LATEST=$(IMAGE):latest

build:
	docker build --force-rm -t $(IMAGE_LATEST) .
	docker tag $(IMAGE_LATEST) $(IMAGE):$(TAG)
	docker push $(IMAGE):$(TAG)
delete:
	docker rmi $(IMAGE):$(TAG)
release:
	docker pull $(IMAGE):$(TAG)
	./scripts/tag-image.sh $(IMAGE)
	./scripts/increment_version.sh -p
	./scripts/tag.sh
	docker rmi $(IMAGE):$(TAG)