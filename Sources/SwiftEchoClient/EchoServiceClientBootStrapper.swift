import Foundation
import NIO
import GRPC
import SwiftEchoModel
import Logging

struct EchoServiceClientBootStrapper {

    func talkTo(serviceOn address: String, listeningTo port: Int, sending message: String) throws {
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
            .connect(host: address, port: port)

        // Provide the connection to the generated client.
        let echo = EchoService_EchoServiceClient(channel: channel)

        // Do the greeting.
        say(message: message, client: echo)
    }

    fileprivate func say(message: String, client echoClient: EchoService_EchoServiceClient) {
        // Form the request with the name, if one was provided.
        let request = EchoService_EchoRequest.with { (request) in
            request.message = message
        }

        // Make the RPC call to the server.
        let echo = echoClient.say(request)

        // wait() on the response to stop the program from exiting before the response is received.
        do {
            let response = try echo.response.wait()
            logger.info("Echo received: \(response)")
        } catch {
            logger.error("Echo failed: \(error)")
        }
    }
}
