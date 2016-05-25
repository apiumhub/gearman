.PHONY: build delete

DOCKER_REGISTRY=127.0.0.1
PROJECT=gearman
PROJECT_UI=gearmanui
TAG=latest
IMAGE=$(DOCKER_REGISTRY)/$(PROJECT)
IMAGE_UI=$(DOCKER_REGISTRY)/$(PROJECT_UI)
IMAGE_LATEST=$(IMAGE):latest
IMAGE_UI_LATEST=$(IMAGE_UI):latest

build:
	docker build --force-rm -t $(IMAGE_LATEST) .
	docker build --force-rm -t $(IMAGE_UI_LATEST) -f Dockerfile.ui .
	docker tag $(IMAGE_LATEST) $(IMAGE):$(TAG)
	docker tag $(IMAGE_UI_LATEST) $(IMAGE_UI):$(TAG)
	docker push $(IMAGE):$(TAG)
	docker push $(IMAGE_UI):$(TAG)
delete:
	docker rmi $(IMAGE):$(TAG)
	docker rmi $(IMAGE_UI):$(TAG)
release:
	./scripts/tag-image.sh $(IMAGE) $(TAG)
	./scripts/tag-image.sh $(IMAGE_UI) $(TAG)
	./scripts/increment_version.sh -p
	./scripts/tag.sh