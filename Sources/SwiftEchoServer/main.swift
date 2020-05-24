import Foundation
import Logging
import ArgumentParser

struct ServiceArguments: ParsableCommand {

    static fileprivate let logger = Logger(label: "ServiceArguments")

    @Option(name: .shortAndLong, help: "IP address to bind to")
    var inet_address: String

    @Option(name: .shortAndLong, help: "TCP/IP port to bind to")
    var port: Int

    func run() throws {
        ServiceArguments.logger.info("Address: \(inet_address)")
        ServiceArguments.logger.info("Port: \(port)")
        try EchoServiceBootStrapper().run(on: inet_address, listeningTo: port)
    }
}

ServiceArguments.main()
