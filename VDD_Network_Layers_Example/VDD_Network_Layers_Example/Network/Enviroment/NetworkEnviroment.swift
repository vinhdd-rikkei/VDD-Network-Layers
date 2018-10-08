//
//  NetworkEnviroment.swift
//  TestNetworkLayers
//
//  Created by vinhdd on 3/21/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import Alamofire

public class NetworkEnviroment {
    
    // MARK: - Local variables
    class var `default`: NetworkEnviroment {
        return NetworkEnviroment(name: ProcessInfo.processInfo.environment["targetName"] ?? "",
                                 host: APIConstants.baseUrl,
                                 headers: APIConstants.httpHeaders,
                                 encoding: URLEncoding.default,
                                 retryTime: 1,
                                 requestTimeout: 10)
    }
    
    // Name of the enviroment (default is name of current scheme)
    public var name: String = ""
    
    // Base URL of the enviroment (default is base url of current scheme)
    public var host: String = ""
    
    // HTTP headers of the enviroment (default is headers of current scheme)
    public var headers: HTTPHeaders = [:]
    
    // URL encoding of the enviroment (default is Encoding Default type)
    public var encoding: ParameterEncoding = URLEncoding.default
    
    // Number of retry time when request API
    public var retryTime: Int = 1
    
    // Request timeout for request
    public var requestTimeout: TimeInterval = 10
    
    // MARK: - Init
    public init() { }
    
    public init(name: String, host: String, headers: HTTPHeaders, encoding: ParameterEncoding, retryTime: Int, requestTimeout: TimeInterval) {
        self.name = name
        self.host = host
        self.headers = headers
        self.encoding = encoding
        self.retryTime = retryTime
        self.requestTimeout = requestTimeout
    }
    
    // MARK: - Builder
    @discardableResult
    public func set(name: String) -> NetworkEnviroment {
        self.name = name
        return self
    }
    
    @discardableResult
    public func set(host: String) -> NetworkEnviroment {
        self.host = host
        return self
    }
    
    @discardableResult
    public func set(headers: HTTPHeaders) -> NetworkEnviroment {
        self.headers = headers
        return self
    }
    
    @discardableResult
    public func set(encoding: URLEncoding) -> NetworkEnviroment {
        self.encoding = encoding
        return self
    }
    
    @discardableResult
    public func set(retryTime: Int) -> NetworkEnviroment {
        self.retryTime = retryTime
        return self
    }
    
    @discardableResult
    public func set(requestTimeout: TimeInterval) -> NetworkEnviroment {
        self.requestTimeout = requestTimeout
        return self
    }
}
