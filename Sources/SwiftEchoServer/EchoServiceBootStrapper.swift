import Foundation
import Logging
import NIO
import GRPC
import SwiftEchoModel

struct EchoServiceBootStrapper {

    static fileprivate let logger = Logger(label: "EchoServiceBootStrapper")

    func run(on address: String, listeningTo port: Int) throws {
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
            .bind(host: address, port: Int(port))

        server.map {
            $0.channel.localAddress
        }.whenSuccess { address in
            EchoServiceBootStrapper.logger.info("server started on port \(address!.port!)")
        }

        // Wait on the server's `onClose` future to stop the program from exiting.
        _ = try server.flatMap {
            $0.onClose
        }.wait()
    }
}
