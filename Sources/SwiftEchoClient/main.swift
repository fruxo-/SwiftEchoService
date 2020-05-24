import Foundation
import Logging
import ArgumentParser

struct ClientArguments: ParsableCommand {

    fileprivate static let logger = Logger(label: "ClientArguments")

    @Option(name: .shortAndLong, help: "IP address of the service")
    var inet_address: String

    @Option(name: .shortAndLong, help: "TCP/IP port of the service")
    var port: Int

    @Argument(help: "The message to send")
    var message: String

    func run() throws {
        ClientArguments.logger.info("Service address: \(inet_address)")
        ClientArguments.logger.info("Service port: \(port)")
        try EchoServiceClientBootStrapper().talkTo(
            serviceOn: inet_address,
            listeningTo: port,
            sending: message
        )
    }
}

ClientArguments.main()
