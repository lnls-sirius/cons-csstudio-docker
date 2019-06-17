.PHONY: python base

DOCKER_MANTAINER_NAME=lnlscon
DOCKER_NAME=cs-studio
DOCKER_TAG=py

python:
	docker build -t ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:${DOCKER_TAG}  -f Dockerfile.Python .
