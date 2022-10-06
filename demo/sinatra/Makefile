IMAGE_NAME := mariorios/sinatra-demo
build::
	docker buildx build --platform linux/arm32v7 -t $(IMAGE_NAME) .

push:: build
	docker push $(IMAGE_NAME)

deploy::
	nomad job run sinatra-demo.nomad
