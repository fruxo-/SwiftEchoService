import Foundation
import Logging
import Metrics
import GRPC
import NIO
import SwiftEchoModel

public class EchoServiceProvider: EchoService_EchoServiceProvider {

    static fileprivate var logger = Logger(label: "EchoServiceProvider")

    fileprivate var sayCounter: AtomicInt = AtomicInt(with: 0)

    public func say(request: EchoService_EchoRequest, context: StatusOnlyCallContext) -> EventLoopFuture<EchoService_EchoRespone> {
        sayCounter.increment(by: 1)

        log([
            "Got request \(context.request)",
            "Got message \(request)"
        ])

        var response = EchoService_EchoRespone()
        response.message = request.message
        return context.eventLoop.makeSucceededFuture(
            response
        )
    }

    private func log(_ lines: [String]) {
        lines.forEach { (line) in
            EchoServiceProvider.logger[metadataKey: "EchoServiceProvider.say.count"] = "\(sayCounter.get())"
            EchoServiceProvider.logger.info("\(line)")
        }
    }
}
