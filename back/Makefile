ifeq ($(OS),Windows_NT)
	BUILD_OS := build-win
else
	BUILD_OS := build-linux
endif

build-linux:
	GOOS=linux GOARCH=amd64 go build -o dist/linux/ main.go

build-win:
	GOOS=windows GOARCH=amd64 go build -o dist/win/ main.go

build-all: build-linux build-win

build: $(BUILD_OS)

run:
	go run main.go

all: build

clean:
	rm -rf ./dist
