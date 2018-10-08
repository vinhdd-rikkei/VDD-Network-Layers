//
//  DispatcherProtocol.swift
//  TestNetworkLayers
//
//  Created by vinhdd on 3/21/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import Hydra
import Alamofire

public protocol DispatcherProtocol {
    // Configure the dispatcher with an enviroment
    init(enviroment: NetworkEnviroment)
    
    // Execute the request
    func execute(request: Request, retry: Int) throws -> Promise<Response>
    func cancel()
    func prepareComponentsFor(request: Request) -> ComponentRequest
    func prepareURLRequestFor(request: Request) -> URLRequestConvertible
}
