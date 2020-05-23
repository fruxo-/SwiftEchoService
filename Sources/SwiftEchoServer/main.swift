import Foundation
import Logging
import ArgumentParser

let logger = Logger(label: "EchoService")

struct ServiceArguments: ParsableCommand {

    @Option(name: .shortAndLong, help: "IP address to bind to")
    var inet_address: String

    @Option(name: .shortAndLong, help: "TCP/IP port to bind to")
    var port: Int

    func run() throws {
        logger.info("Address: \(inet_address)")
        logger.info("Port: \(port)")
        try EchoServiceBootStrapper().run(on: inet_address, listeningTo: port)
    }
}

// Quieten the logs.
LoggingSystem.bootstrap {
    var handler = StreamLogHandler.standardOutput(label: $0)
    handler.logLevel = .critical
    return handler
}

ServiceArguments.main()
