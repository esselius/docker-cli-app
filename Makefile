.PHONY: test deploy

AUTHOR=esselius
APP=docker-cli-app

BUCKET=${APP}
TAG=$(shell git rev-parse --short HEAD)

test: build
	docker run ${AUTHOR}/${APP}:${TAG} test

build:
	docker build -t ${AUTHOR}/${APP}:${TAG} .

tag-latest: build
	docker tag ${AUTHOR}/${APP}:${TAG} ${AUTHOR}/${APP}:latest

pull:
	docker pull ${AUTHOR}/${APP}:latest || true

push: pull tag-latest
	docker push ${AUTHOR}/${APP}:${TAG}
	docker push ${AUTHOR}/${APP}:latest

deploy: push
	sed "s/AUTHOR/${AUTHOR}/g" s3/runner.sh | sed "s/APP/${APP}/g" |sed "s/TAG/${TAG}/" | aws s3 cp - s3://${BUCKET}/runner.sh --acl public-read
	sed "s/BUCKET/${BUCKET}/" s3/downloader.sh | aws s3 cp - s3://${BUCKET}/downloader.sh --acl public-read
