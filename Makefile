.PHONY: build
build:
		go build -v ./cmd/apiserver

.PHONY: test
test:
		go test -v -race -timeout 30s ./...

.PHONY: start-db
start-db:
		docker-compose --compatibility -f ./build/docker-compose.yml up

.DEFAULT_GOAL := build
