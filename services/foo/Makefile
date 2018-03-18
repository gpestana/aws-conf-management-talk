SERVICE_NAME=`basename "$(PWD)"`
SERVICE_VERSION=`git rev-parse --short=8 HEAD`
SERVICE=${SERVICE_NAME}-${SERVICE_VERSION}-${RELEASE}
AWS_ACCOUNT_ID=494917051385
AWS_REGION=eu-west-1
REPO_NAMESPACE=ec-registry
ECR_REPO=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAMESPACE}

build:
	docker build -t foo . && \
		docker run --name foo foo &

destroy:
	docker rm -f foo

docker: docker-build-tag docker-push

ecr-login:
	aws ecr get-login --region eu-west-1 --no-include-email | bash

docker-build-tag:
	docker build . --tag ${ECR_REPO}:${SERVICE}


docker-push:
	docker push ${ECR_REPO}:${SERVICE}
