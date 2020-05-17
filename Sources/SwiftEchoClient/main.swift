import Foundation
import Logging
import NIO
import GRPC
import SwiftEchoModel

print("Client starting...")

// Quieten the logs.
LoggingSystem.bootstrap {
    var handler = StreamLogHandler.standardOutput(label: $0)
    handler.logLevel = .critical
    return handler
}

func say(message: String?, client echoClient: EchoService_EchoServiceClient) {
    // Form the request with the name, if one was provided.
    let request = EchoService_EchoRequest.with { (request) in
        request.message = message ?? "Default"
    }

    // Make the RPC call to the server.
    let echo = echoClient.say(request)

    // wait() on the response to stop the program from exiting before the response is received.
    do {
        let response = try echo.response.wait()
        print("Echo received: \(response.message)")
    } catch {
        print("Echo failed: \(error)")
    }
}

func main(args: [String]) {
    // arg0 (dropped) is the program name. We expect arg1 to be the port, and arg2 (optional) to be
    // the name sent in the request.
    let host = args.dropFirst(1).first
    let port = args.dropFirst(2).first
    let message = args.dropFirst(3).first

    switch (host, port.flatMap(Int.init), message) {

    case let (.some(host), .some(port), .some(message)):
        // Setup an `EventLoopGroup` for the connection to run on.
        //
        // See: https://github.com/apple/swift-nio#eventloops-and-eventloopgroups
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)

        // Make sure the group is shutdown when we're done with it.
        defer {
            try! group.syncShutdownGracefully()
        }

        // Configure the channel, we're not using TLS so the connection is `insecure`.
        let channel = ClientConnection.insecure(group: group)
            .connect(host: host, port: port)

        // Provide the connection to the generated client.
        let echo = EchoService_EchoServiceClient(channel: channel)

        // Do the greeting.
        say(message: message, client: echo)

    default:
        print("Usage: SERVER_HOST SERVER_PORT [MESSAGE]")
        exit(1)
    }
}

main(args: CommandLine.arguments)
