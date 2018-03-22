//
//  NetworkEnviroment.swift
//  TestNetworkLayers
//
//  Created by vinhdd on 3/21/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import Alamofire

public struct NetworkEnviroment {
    // Singleton variable, for using default configuration if needed
    static var shared = NetworkEnviroment()
    
    // Name of the enviroment (default is name of current scheme)
    public var name: String = ProcessInfo.processInfo.environment["targetName"] ?? ""

    // Base URL of the enviroment (default is base url of current scheme)
    public var host: String = APIConstants.baseUrl
    
    // HTTP headers of the enviroment (default is headers of current scheme)
    public var headers: HTTPHeaders = APIConstants.httpHeaders
    
    // URL encoding of the enviroment (default is HTTP body type)
    public var encoding: URLEncoding = .httpBody
    
    public init() { }
    
    public init(_ name: String, host: String, headers: HTTPHeaders, encoding: URLEncoding) {
        self.name = name
        self.host = host
        self.headers = headers
        self.encoding = encoding
    }
}
