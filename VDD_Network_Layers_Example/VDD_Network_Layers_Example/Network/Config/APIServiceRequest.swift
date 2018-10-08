//
//  NetworkEnviroment.swift
//  TestNetworkLayers
//
//  Created by vinhdd on 3/21/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

public class ComponentRequest {
    
    var fullUrl: String?
    var method: HTTPMethod?
    var httpHeaders: HTTPHeaders?
    var parameters: Parameters?
    var encoding: ParameterEncoding?
    
    init(request: Request, enviroment: NetworkEnviroment) {
        // Request url
        fullUrl = enviroment.host + "/" + request.path
        
        // Method
        method = request.method
        
        // Encoding
        encoding = request.method == .get ? URLEncoding.default : enviroment.encoding
        
        // Http headers
        httpHeaders = enviroment.headers
        if let requestHeader = request.headers {
            requestHeader.forEach {
                httpHeaders?[$0.key] = $0.value
            }
        }
        
        // Parameters
        switch request.parameters {
        case .body(let params): parameters = params
        case .url(let params): parameters = params
        }
        
        print("\n[Request API] -> [\(request.apiIdentifier)] -> Preparing...")
        print("⬩ Full url: \(fullUrl ?? "-")")
        print("⬩ Method: \(String(describing: method))")
        let headersToPrint = httpHeaders ?? [:]
        if headersToPrint.count > 0 {
            print("⬩ HTTP Headers:\n\(headersToPrint)")
        } else {
            print("⬩ HTTP Headers: empty")
        }
        let paramsToPrint = JSON(parameters ?? [:])
        if paramsToPrint.count > 0 {
            print("⬩ Parameters:\n\(paramsToPrint)")
        } else {
            print("⬩ Parameters: empty")
        }
        print("⬩ Encoding: \(String(describing: encoding))")
        print("-> [\(request.apiIdentifier)] Requesting...")
    }
}

class ConvertibleRequest: URLRequestConvertible {
   
    private var request: Request
    private var enviroment: NetworkEnviroment
    
    init(request: Request, enviroment: NetworkEnviroment) {
        self.request = request
        self.enviroment = enviroment
    }
    
    func asURLRequest() throws -> URLRequest {
        // Request url
        let fullUrl = enviroment.host + "/" + request.path
        var urlRequest = URLRequest(url: URL(string: fullUrl)!)
        
        // Method
        urlRequest.httpMethod = request.method.rawValue
        
        // Timeout interval
        urlRequest.timeoutInterval = enviroment.requestTimeout
        
        // Http headers
        enviroment.headers.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        request.headers?.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        // Parameters
        var parameters: Parameters?
        switch request.parameters {
        case .body(let params): parameters = params
        case .url(let params): parameters = params
        }
        
        print("\n[Request API] -> [\(request.apiIdentifier)] -> Preparing...")
        print("⬩ Full url: \(fullUrl)")
        print("⬩ Method: \(request.method.rawValue)")
        let headersToPrint = JSON(urlRequest.allHTTPHeaderFields ?? [:])
        if headersToPrint.count > 0 {
            print("⬩ HTTP Headers:\n\(headersToPrint)")
        } else {
            print("⬩ HTTP Headers: empty")
        }
        let paramsToPrint = JSON(parameters ?? [:])
        if paramsToPrint.count > 0 {
            print("⬩ Parameters:\n\(paramsToPrint)")
        } else {
            print("⬩ Parameters: empty")
        }
        print("-> [\(request.apiIdentifier)] Requesting...")
        return try enviroment.encoding.encode(urlRequest, with: parameters)
    }
}
