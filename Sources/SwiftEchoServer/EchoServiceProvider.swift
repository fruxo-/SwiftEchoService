import Foundation
import Logging
import GRPC
import NIO
import SwiftEchoModel

public class EchoServiceProvider: EchoService_EchoServiceProvider {

    static fileprivate let logger = Logger(label: "EchoServiceProvider")

    public func say(request: EchoService_EchoRequest, context: StatusOnlyCallContext) -> EventLoopFuture<EchoService_EchoRespone> {
        EchoServiceProvider.logger.info("Got request \(context.request)")
        EchoServiceProvider.logger.info("Got message \(request)")

        var response = EchoService_EchoRespone()
        response.message = request.message
        return context.eventLoop.makeSucceededFuture(
            response
        )
    }
}
