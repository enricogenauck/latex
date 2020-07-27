NAME   := enricogenauck/latex
TAG    := $$(git log -1 --pretty=%h)
IMG    := ${NAME}:${TAG}
LATEST := ${NAME}:latest

build:
	@docker build -t ${IMG} .
	@docker tag ${IMG} ${LATEST}

push:
	@docker push ${NAME}

exec: build
	docker run --rm --volume="$$PWD:/src" -it ${LATEST} $$COMMAND
