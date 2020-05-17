//
//  File.swift
//  
//
//  Created by Ciccio on 16/05/2020.
//

import Foundation
import GRPC
import NIO
import SwiftEchoModel

public class EchoServiceProvider: EchoService_EchoServiceProvider {

    public func say(request: EchoService_EchoRequest, context: StatusOnlyCallContext) -> EventLoopFuture<EchoService_EchoRespone> {
        print("Got request \(request)")
        var response = EchoService_EchoRespone()
        response.message = request.message
        return context.eventLoop.makeSucceededFuture(
            response
        )
    }
}
