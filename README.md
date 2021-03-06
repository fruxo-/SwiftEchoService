# SwiftEcho

An echo server and client written in Swift.

## Getting the sources
```
git clone https://github.com/fruxo-/SwiftEchoService.git
```

# Running
## Via Docker
```
docker build --no-cache -t swift_echo_service:latest .
docker run -it -d -p 8888:8888 swift_echo_service:latest
```

To "jump" into the image:
```
docker exec -it [CONTAINER_ID] bash
```

## From your OS
## Pre-requisites
1. The Swift runtime and compiler.

###  Running the server
```
swift run SwiftEchoServer -i HOST -p PORT
```
### Running the client
```
swift run SwiftEchoClient -i SEVER_HOST -p SERVER_PORT MESSAGE 
```

# Building
## Pre-requisites
1. The Swift runtime and compiler.

## Compiling the protocol
```
swift build --target SwiftEchoModel
```

## Compiling the service
```
swift build --target SwiftEchoServer
```

## Compiling the client
```
swift build --target SwiftEchoClient
```

# Contributing
## Pre-requisites
1. Check out https://github.com/protocolbuffers/protobuf
1. Build it and add `protoc` to `PATH`
1. Checkout https://github.com/grpc/grpc-swift
1. Do `make plugins` and add both `protoc-gen-*` executables to `PATH`

## Generating the protocol files
```
protoc --swift_opt=Visibility=Public --swift_out=. Sources/Model/swift_echo_server.proto
```

## Generating the service and client files
```
protoc --grpc-swift_opt=Visibility=Public --grpc-swift_out=. Sources/Model/swift_echo_server.proto
```
