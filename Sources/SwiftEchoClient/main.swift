import Foundation
import Logging
import ArgumentParser

let logger = Logger(label: "EchoClient")

struct ClientArguments: ParsableCommand {

    @Option(name: .shortAndLong, help: "IP address of the service")
    var inet_address: String

    @Option(name: .shortAndLong, help: "TCP/IP port of the service")
    var port: Int

    @Argument(help: "The message to send")
    var message: String

    func run() throws {
        logger.info("Service address: \(inet_address)")
        logger.info("Service port: \(port)")
        try EchoServiceClientBootStrapper().talkTo(
            serviceOn: inet_address,
            listeningTo: port,
            sending: message
        )
    }
}

// Quieten the logs.
LoggingSystem.bootstrap {
    var handler = StreamLogHandler.standardOutput(label: $0)
    handler.logLevel = .critical
    return handler
}

ClientArguments.main()
