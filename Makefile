# Read version from the git tag or branch name
VERSION := $(shell git describe --tags --always)

clean:
	rm -rf dist

test:
	ginkgo -r

makedist:
	mkdir -p ./dist

build-linux:
	CGO_ENABLED=1 GOOS=linux GOARCH=amd64 CC=gcc go build -ldflags="-s -w" -buildmode=plugin -o ./dist/if-executor-linux-amd64-$(VERSION).so .
	CGO_ENABLED=1 GOOS=linux GOARCH=arm64 CC=aarch64-linux-gnu-gcc go build -ldflags="-s -w" -buildmode=plugin -o ./dist/if-executor-linux-arm64-$(VERSION).so .

build-darwin:
	CGO_ENABLED=1 GOOS=darwin GOARCH=amd64 go build -ldflags="-s -w"  -buildmode=plugin -o ./dist/if-executor-darwin-amd64-$(VERSION).so .
	CGO_ENABLED=1 GOOS=darwin GOARCH=arm64 go build -ldflags="-s -w" -buildmode=plugin -o ./dist/if-executor-darwin-arm64-$(VERSION).so .

build-windows:
	CGO_ENABLED=1 GOOS=windows GOARCH=amd64 go build -ldflags="-s -w" -buildmode=plugin -o ./dist/if-executor-windows-amd64-$(VERSION).so .
	CGO_ENABLED=1 GOOS=windows GOARCH=arm64 go build -ldflags="-s -w" -buildmode=plugin -o ./dist/if-executor-windows-arm64-$(VERSION).so .

depensure:
	go mod tidy
	go mod vendor

# Build for all platforms
build: clean makedist depensure
	make build-linux
	make build-darwin
	make build-windows