import Foundation
import Logging
import NIO
import GRPC
import SwiftEchoModel

print("Server starting...")

// Quieten the logs.
LoggingSystem.bootstrap {
    var handler = StreamLogHandler.standardOutput(label: $0)
    handler.logLevel = .critical
    return handler
}

func main(args: [String]) throws {
    // arg0 (dropped) is the program name. We expect arg1 to be the port, and arg2 (optional) to be
    // the name sent in the request.
    let address = args.dropFirst(1).first
    let port = args.dropFirst(2).first

    switch (address, port) {
    case (.none, .none):
        print("Usage: ADDRESS PORT")
        exit(1)

    case let (address, port):
        // Setup an `EventLoopGroup` for the connection to run on.
        // See: https://github.com/apple/swift-nio#eventloops-and-eventloopgroups
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        // Make sure the group is shutdown when we're done with it.
        defer {
            try! group.syncShutdownGracefully()
        }

        // Start the server and print its address once it has started.
        let server = Server.insecure(group: group)
            .withServiceProviders([EchoServiceProvider()])
            .bind(host: address!, port: Int(port!)!)

        server.map {
            $0.channel.localAddress
        }.whenSuccess { address in
            print("server started on port \(address!.port!)")
        }

        // Wait on the server's `onClose` future to stop the program from exiting.
        _ = try server.flatMap {
            $0.onClose
        }.wait()
    }
}

try main(args: CommandLine.arguments)
