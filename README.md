# SwiftEcho

An echo server and client written in Swift.

# Building
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

# Running
## Running the server
```
swift run SwiftEchoServer HOST PORT
```
## Running the client
```
swift run SwiftEchoClient SEVER_HOST SERVER_PORT MESSAGE 
```
